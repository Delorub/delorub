module Profile::Contract
  class Form < Reform::Form
    collection :main_categories_profiles,
      populator: ->(collection:, fragment:, **) {
        item = collection.find_by(id: fragment['id'])
        if fragment['main_category_id'].present?
          category = Category.find_by(id: fragment['main_category_id'], parent_id: nil)
          return skip! if category.nil?
        end
        item ? item : collection.append(MainCategoriesProfile.new)
      } do
      property :id
      property :main_category_id
      property :description
      property :category_ids,
        virtual: true,
        default: [],
        prepopulator: ->(**) {
          self.category_ids = model.profile.categories.where(parent_id: model.main_category_id).ids
        },
        populator: ->(fragment:, **) {
          self.category_ids = Category.where(id: fragment, parent_id: main_category_id).pluck(:id)
        }

      validates :main_category_id, presence: true
    end

    property :about
    property :price_project
    property :birthday
    property :place_id

    property :category_ids, parse: false

    validates :about, presence: true

    def deserialize! document
      # TODO: find the right way to delete unpopulated elements from collection
      main_categories_profiles.each do |item|
        next if document[:main_categories_profiles].map { |e| e['id'].to_i }.include? item.id
        main_categories_profiles.delete item
      end

      self.category_ids = document[:main_categories_profiles].map do |e|
        if e[:category_ids].nil?
          []
        else
          e[:category_ids].map(&:to_i)
        end
      end.flatten.uniq

      super
    end

    def cities_list
      Place.only_cities.map { |a| { label: a.full_name, value: a.id } }
    end
  end

  class GuestForm < Form
    property :new_user,
      prepopulator: ->(options) { self.new_user = User.new },
      populator: ->(model:, **) { model || self.new_user = User.new },
      form: User::Contract::Registration,
      virtual: true
  end

  class UserForm < Form
  end
end
