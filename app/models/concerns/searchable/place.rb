module Searchable::Place
  extend ActiveSupport::Concern

  included do
    searchkick word_start: [:name, :full_name, :search_string], language: :russian
    
    scope :by_search_in, ->(q) {
      data = PlaceSearch.new(query: q, page: 1, per_page: 100).all.map(&:id)
      if data
        unscoped.where(id: data).order("field(id, #{data.join(',')})")
      else
        scoped
      end
    }
    
    def self.ransackable_scopes(auth_object = nil)
      [:by_search_in]
    end
  end

  def search_data
    {
      full_name: full_name,
      name: name,
      place_type_name: place_type_name.search_string,
      search_string: search_string
    }
  end
  
  def search_name
    if place_type_name
      [place_type_name.name, place_type_name.full_name, place_type_name.alt_name].compact.map do |place_name|
        if place_type_name.after_place_name
          "#{name} #{place_name}"
        else
          "#{place_name} #{name}"
        end
      end.join(" ")
    else
      name
    end
  end
  
  def search_string
    if parent_place
      "#{search_name} #{parent_place.search_string}"
    else
      search_name
    end
  end
end