class UserPermissionData
  extend JsonSerializable

  def self.pretty_permissions
    {
      admin:
      {
        dashboard: [],
        search: [],
        place: [],
        user_billing_log: [],
        task: [ :view, :edit, :delete ],
        category: [ :view, :edit, :delete ],
        news: [ :view, :edit, :delete ],
        user: [ :view, :edit, :delete, :permissions, :billing ],
        page: [ :view, :edit, :delete ],
        reply: []
      },

      editor:
      {
        dashboard: [],
        user: [ :permissions, :block, :billing ],
        news: [],
        task: [],
        reply: []
      },
      
      superadmin: []
    }
  end

  def respond_to? method, *args
    super || self.class.permissions.include?(key method)
  end

  def method_missing method, *args, &block
    key = key(method)
    if self.class.permissions.include? key
      if action(method) == :set
        set key, args.first
      else
        get key
      end
    else
      super
    end
  end
  
  def key method
    method.to_s.gsub(/[=\?]/, '').to_sym
  end
  
  def action sym
    sym.to_s.last == '=' ? :set : :get
  end

  def values= values
    values.each { |k, v| set k, v }
  end
  
  def values
    @values
  end

  def initialize previous_values = {}
    previous_values ||= {}
    replace @previous_values = previous_values.symbolize_keys
  end
  
  def initialize_dup other
    @values = other.instance_variable_get(:@values).clone
    @previous_values = other.instance_variable_get(:@previous_values).clone
    super
  end
  
  def self.permissions
    @permissions ||= flatten_pretty_permissions pretty_permissions
  end
  
  def self.have_permission? permission
    self.permissions.include? permission.to_s.gsub(/[=\?]/, '').to_sym
  end

  def set key, value
    if TRUE_VALUES.include? value
      @values[key] = true
    else
      @values.delete(key)
    end
  end
  TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE'].freeze

  def get key
    @values[key] ? true : false
  end

  def changed?
    @previous_values != @values
  end

  def changed
    changes.keys
  end

  def changes
    @values.diff @previous_values
  end
  
  def as_json params = {}
    @values.merge(params).keep_if { |k, v| v == true }
  end
  
  def empty?
    @values.empty?
  end

  private
  
    def self.flatten_pretty_permissions permissions, prefix: nil
      permissions.map do |k, v|
        t = make_permission_title(k, prefix: prefix)
        [t, flatten_pretty_permissions(v, prefix: t)].flatten.compact
      end.flatten.uniq unless permissions.nil?
    end
    
    def self.make_permission_title title, prefix: nil
      if prefix.nil?
        title
      else
        "#{prefix.to_s}_#{title.to_s}".to_sym
      end
    end
    
    def replace new_values = {}
      new_values ||= {}
      @values = new_values.symbolize_keys.keep_if { |k, v| v == true && self.class.permissions.key?(k) }
    end
end