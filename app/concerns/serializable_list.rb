module Configurable
  def initialize previous_values = {}
    previous_values ||= {}
    replace @previous_values = previous_values.symbolize_keys
  end

  # TL;DR: instance variables are not copied in Kernel#dup by design and all instances share the same state
  #
  # Rails calls Kernel#dup on default attributes when instantiating new model instance, but
  # Kernel#dup does not copy instance variables and because of that if you modify attributes - you modify the same
  # variable @values that is in default attributes and all new model instances get modified default attributes
  def initialize_dup other
    @values = other.instance_variable_get(:@values).clone
    @previous_values = other.instance_variable_get(:@previous_values).clone
    super
  end

  def method_missing method, *args, &block
    key = key(method)

    if @values.key? key
      if action(method) == :set
        set key, args.first
      else
        get key
      end
    else
      super
    end
  end

  def respond_to? method, *args
    super || @values.key?(key method)
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

  def set key, value
    @values[key] = value
  end

  def get key
    # Use ActiveSupport implemented of this feature
    if boolean_field? key
      TRUE_VALUES.include? @values[key]
    elsif @values[key].is_a? Proc
      @values[key].call
    elsif default_values[key].is_a? Numeric
      @values[key].to_i
    else
      @values[key]
    end
  end

  def boolean_field? key
    value = default_values[key]
    [FalseClass, TrueClass].include? value.class
  end
  TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE'].freeze

  def persisted?
    false
  end

  def default_values
    self.class.default_values
  end

  def self.default_values
    {}
  end

  def reset_to_defaults!
    @values = default_values
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
    values_without_procs @values.merge(params)
  end

  def values_without_procs original_values
    original_values.dup.tap do |values|
      values.each { |k, v| values[k] = v.call if v.is_a? Proc }
    end
  end

  def replace new_values = {}
    new_values ||= {}
    @values = self.class.default_values.symbolize_keys.merge new_values.symbolize_keys
  end
end
