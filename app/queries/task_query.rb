class TaskQuery
  attr_accessor :scope, :category, :current_user, :collection

  def initialize collection:, scope:, category:, current_user:
    @collection = collection
    @scope = scope
    @category = category
    @current_user = current_user
  end

  def perform
    apply_user if scope == :my
    apply_category if category
    collection
  end

  private

    def apply_user
      @collection = collection.by_user current_user
    end

    def apply_category
      @collection = collection.by_category_with_descendants category
    end
end
