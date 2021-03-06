class ProfileQuery
  attr_accessor :category, :collection, :page, :direction, :place

  def initialize collection:, category:, page:, direction:, place: nil
    @collection = collection
    @category = category
    @page = page.to_i.positive? ? page : 1
    @direction = direction.present? && direction.to_i == 1 ? 'asc' : 'desc'
    @place = place
  end

  def perform
    apply_collection
    if category
      apply_main_category if category.root?
      apply_category if category.child?
    end
    apply_place if place
    apply_order
    apply_paginate
    collection
  end

  private

    def apply_collection
      @collection = collection.includes(:user)
    end

    def apply_main_category
      @collection = collection.by_main_category category
    end

    def apply_category
      @collection = collection.by_category category
    end

    def apply_place
      @collection = collection.where(place_id: place.id)
    end

    def apply_order
      @collection = collection.order(created_at: direction)
    end

    def apply_paginate
      @collection = collection.page(page).per(10)
    end
end
