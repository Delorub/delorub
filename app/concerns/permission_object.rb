module PermissionObject
  extend ActiveSupport::Concern

  def respond_to_missing? method_name, include_private = false
    method_key = key method_name
    super || self.class.permissions.include?(method_key)
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

  def replace new_values = {}
    new_values ||= {}
    @values = new_values.symbolize_keys.keep_if { |k, v| v == true && self.class.permissions.key?(k) }
  end

  module ClassMethods
    def flatten_pretty_permissions permissions, prefix: nil
      return if permissions.nil?
      permissions.map do |k, v|
        t = make_permission_title(k, prefix: prefix)
        [t, flatten_pretty_permissions(v, prefix: t)].flatten.compact
      end.flatten.uniq
    end

    def make_permission_title title, prefix: nil
      if prefix.nil?
        title
      else
        "#{prefix}_#{title}".to_sym
      end
    end

    def permissions
      @permissions ||= flatten_pretty_permissions pretty_permissions
    end

    def permission? permission
      permissions.include? permission.to_s.gsub(/[=\?]/, '').to_sym
    end
  end
end
