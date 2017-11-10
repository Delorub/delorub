class ExternalData::Presenter
  attr_reader :model

  def initialize model
    @model = model
  end

  class << self
    def for model
      (name.split('::') + model.source.split('_').map(&:capitalize)).join('::').constantize.new(model)
    end
  end
end
