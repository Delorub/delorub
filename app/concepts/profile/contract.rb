module Profile::Contract
  class Form < Reform::Form
    collection :main_categories_profiles,
      populator: ->(fragment:, **) {
        item = main_categories_profiles.find { |e| e.id == fragment['id'].to_i }
        item ? item : main_categories_profiles.append(MainCategoriesProfile.new(main_category_id: fragment['id']))
      } do
      property :main_category_id
      property :description
      property :category_ids,
        virtual: true,
        default: [],
        populator: ->(fragment:, **) {
          self.category_ids = Category.where(id: fragment, parent_id: main_category_id).pluck(:id)
        }
    end

    property :about
    property :price_project
    property :birthday
    property :city_id

    validates :about, presence: true

    def main_category_collection
      Category.roots
    end

    def categories_list
      Category.all.map { |e| { label: e.title, value: e.id, parent_id: e.parent_id } }
    end

    def cities_list
      City.active.map { |a| { label: a.name, value: a.id } }
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
