class ProfileQuery
  attr_accessor :category, :current_user, :collection

  def initialize collection:, category:, current_user:
    @collection = collection
    @category = category
    @current_user = current_user
  end

  def perform
    apply_category if category
    apply_order
    collection
  end

  private

    def apply_user
      @collection = collection.by_user current_user
    end

    def apply_category
      @collection = collection.by_category_with_descendants category
    end

    def apply_order
      @collection = collection.order('id DESC')
    end
end
