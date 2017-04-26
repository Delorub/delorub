class CreateProfileForm < Reform::Form

  collection :specializations do
    property :category_id
  end

  def to_redux
    {
      photo_url: nil,
      main_specialization_id: nil,
      specializations: specializations
    }
  end
end
