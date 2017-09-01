module Task::Contract
  class Form < ::BaseForm
    property :title
    property :description

    property :category_id,
      prepopulator: ->(options) {
        return if options[:category].nil?
        self.category_id = if options[:category].parent_id.nil?
                             options[:category].id
                           else
                             options[:category].parent_id
                           end
      }
    property :subcategory_ids,
      default: [],
      prepopulator: ->(options) {
        return if options[:category].nil?
        self.subcategory_ids = [options[:category].id] unless options[:category].parent_id.nil?
      },
      populator: ->(fragment:, **) {
        self.subcategory_ids = Category.where(id: fragment).pluck(:id)
      }

    property :date_type, default: 'interval'
    property :date_actual, default: -> { I18n.l(Time.zone.now + 1.day, format: :datepicker) }
    property :date_interval_from, default: -> { I18n.l(Time.zone.now, format: :datepicker) }
    property :date_interval_to, default: -> { I18n.l(Time.zone.now + 1.day, format: :datepicker) }

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
      required(:subcategories_ids)
    end

    def category
      Category.find_by id: category_id
    end

    def main_category_collection
      Category.roots
    end

    def categories_list
      Category.all.map { |e| { label: e.title, value: e.id, parent_id: e.parent_id } }
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
