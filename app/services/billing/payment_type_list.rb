class Billing::PaymentTypeList
  BALANCE = [:balance].freeze
  YANDEX_KASSA = [:qiwi, :yandex, :visa, :webmoney].freeze

  attr_reader :model

  def initialize model
    @model = model
  end

  def perform
    case model.class
      when Billing::YandexKassa::Deposit
        YANDEX_KASSA
      else
        BALANCE + YANDEX_KASSA
    end
  end

  def self.for model
    new(model).perform
  end
end
