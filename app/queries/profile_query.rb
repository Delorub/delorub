class ProfileQuery
  attr_accessor :category, :current_user, :collection, :page, :direction

  def initialize collection:, category:, current_user:, page:, direction:
    @collection = collection
    @category = category
    @current_user = current_user
    @page = page
    @direction = direction.present? && direction.to_i == 1 ? true : false
  end

  def perform
    apply_collection
    apply_category if category
    apply_order
    apply_paginate
    collection
  end

  private

    def apply_collection
      @collection = collection.includes(:user)
    end

    def apply_user
      @collection = collection.by_user current_user
    end

    def apply_category
      @collection = collection.by_category_with_descendants category
    end

    def apply_order
      @collection = direction ? collection.order(created_at: :asc) : collection.order('id DESC')
    end

    def apply_paginate
      @collection = collection.page(page.to_i.positive? ? page : 1).per(4)
    end
end
