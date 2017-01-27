class PlaceTypeName < ActiveRecord::Base
  def display_name
    if alt_name
      alt_name
    else
      name
    end
  end
  
  def search_string
    [name, full_name, alt_name].compact.join(" ")
  end
end
