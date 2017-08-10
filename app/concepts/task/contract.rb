module Task::Contract
  class Form < ::BaseForm
    property :title
    property :description

    property :category_id
    property :main_category_id, virtual: true

    property :date_type, default: 'interval'
    property :date_actual_date, default: -> { I18n.l(Time.zone.now + 1.day, format: :date) }, virtual: true
    property :date_actual_time, default: -> { I18n.l(Time.zone.now, format: :timeofday) }, virtual: true
    property :date_interval_from_date, default: -> { I18n.l(Time.zone.now, format: :date) }, virtual: true
    property :date_interval_to_date, default: -> { I18n.l(Time.zone.now + 1.day, format: :date) }, virtual: true

    property :price_type, default: 'exact'
    property :price_exact
    property :price_scale

    property :place_id
    property :place_lat
    property :place_long
    property :place_address

    collection :files,
      populator: ->(fragment:, **) {
        item = files.find { |file| file.id == fragment['id'].to_i }
        item ? item : files.append(TaskFile.find_by(id: fragment['id']))
      } do
      property :id
    end

    property :contract_type, default: 'no_contract'

    property :notifications_type, virtual: true, default: 'notifications-email'
    property :paid_functions, virtual: true, default: ''

    validation :default do
      configure do
        config.messages = :i18n
      end

      required(:title).filled
      required(:description).filled
      required(:category_id).filled

      required(:price_exact).filled(:int?)
    end

    def notifications_type_options
      [
        ['На email и в уведомлениях', 'notifications-email'],
        ['Только уведомления', 'notifications']
      ]
    end

    def paid_functions_options
      [
        ['Выделить цветом', 'color'],
        ['Поднять вверх', 'stick']
      ]
    end
  end

  class GuestForm < Form
    property :new_user,
      prepopulator: ->(options) { self.new_user = User.new },
      populator: ->(model:, **) { model || self.new_user = User.new },
      form: User::Registration::Form,
      virtual: true
  end

  class UserForm < Form
  end
end
