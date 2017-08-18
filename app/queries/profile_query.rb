class ProfileQuery
  attr_accessor :category, :current_user, :collection, :page

  def initialize collection:, category:, current_user:, page:
    @collection = collection.includes(:user)
    @category = category
    @current_user = current_user
    @page = page
  end

  def perform
    apply_category if category
    apply_order
    apply_paginate
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

    def apply_paginate
      @collection = collection.page(page.to_i.positive? ? page : 1).per(4)
    end
end
