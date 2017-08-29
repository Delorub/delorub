class CategoryQuery
  attr_accessor :collection

  def initialize collection:
    @collection = collection
  end

  def perform
    apply_categories
  end

  private

    def apply_categories
      @collection = @collection.roots.includes(:children).order(:position)
    end
end
