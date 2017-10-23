class Billing::PaymentTypeList
  BALANCE = [:balance].freeze
  # YANDEX_KASSA = [:visa, :qiwi, :yandex, :webmoney].freeze
  YANDEX_KASSA = [:visa, :yandex].freeze

  attr_reader :model

  def initialize model
    @model = model
  end

  def perform
    case class_name
      when 'Billing::YandexKassa::Deposit'
        YANDEX_KASSA
      else
        BALANCE + YANDEX_KASSA
    end
  end

  def self.for model
    new(model).perform
  end

  private

    def class_name
      return model.name if model.class.to_s == 'Class'
      model.class.name
    end
end
