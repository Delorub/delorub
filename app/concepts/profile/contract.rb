module Profile::Contract
  class Form < Reform::Form
    property :category_ids,
      default: [],
      populator: ->(fragment:, **) {
        self.category_ids = Category.where(id: fragment).pluck(:id)
      }

    collection :portfolio_items,
      populator: ->(fragment:, **) {
        item = portfolio_items.find { |portfolio_item| portfolio_item.id == fragment['id'].to_i }
        item ? item : portfolio_items.append(PortfolioItem.find_by(id: fragment['id'], profile_id: nil))
      } do
      property :id
    end

    property :about

    validates :category_ids, :about, presence: true

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
