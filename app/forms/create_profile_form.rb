class CreateProfileForm < Reform::Form
  property :main_specialization_id, virtual: true

  collection :specializations do
    property :category_id
  end
end
