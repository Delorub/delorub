class BaseCreator
  attr_reader :form, :model, :hash

  def initialize form
    @form = form
    @model = nil
    @hash = nil
  end

  def last_error
    return unless model
    return if model.errors.empty?
    model.errors[model.errors.keys.first].first
  end
end
