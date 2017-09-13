module Task::Contract
  class Form < ::BaseForm
    property :title
    property :description

    collection :files,
      populator: ->(collection:, fragment:, **) {
        item = collection.find_by(id: fragment['id'])
        item ? item : collection.append(TaskFile.find_by(id: fragment['id']))
      } do
      property :id
      property :file, parse: false
    end

    property :category_id,
      prepopulator: ->(options) {
        return if options[:category].nil?
        self.category_id = if options[:category].parent_id.nil?
                             options[:category].id
                           else
                             options[:category].parent_id
                           end
      },
      populator: ->(fragment:, **) {
        category = Category.roots.find_by(id: fragment)
        return if category.blank?
        self.category_id = category.id
        self.subcategory_ids = []
      }
    property :subcategory_ids,
      default: [],
      prepopulator: ->(options) {
        return if options[:category].nil?
        self.subcategory_ids = [options[:category].id] unless options[:category].parent_id.nil?
      },
      populator: ->(fragment:, **) {
        self.subcategory_ids = Category.where(id: fragment, parent_id: category_id).pluck(:id)
      }

    property :date_type, default: 'interval'
    property :date_actual, default: -> { Time.zone.now + 1.day }
    property :date_interval_from, default: -> { Time.zone.now }
    property :date_interval_to, default: -> { Time.zone.now + 1.day }

    property :price_type, default: 'exact'
    property :price_exact
    property :price_scale

    property :place_id
    property :place_lat
    property :place_long
    property :place_address

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

    def deserialize! document
      # TODO: find the right way to delete unpopulated elements from collection
      files.each do |item|
        next if document[:files].map { |e| e['id'].to_i }.include? item.id
        files.delete item
      end

      super
    end
  end

  class GuestForm < Form
    property :new_user,
      prepopulator: ->(options) { self.new_user = User.new },
      populator: ->(model:, **) { model || self.new_user = User.new },
      form: User::Contract::InlineRegistration,
      virtual: true
  end

  class UserForm < Form
  end
end
