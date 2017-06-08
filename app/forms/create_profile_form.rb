class CreateProfileForm < Reform::Form
  property :main_specialization_id, virtual: true

  collection :specializations do
    property :category_id
  end

  property :about
  property :place_id

  property :notifications_type, virtual: true, default: 'notifications-email'
  property :paid_functions, virtual: true, default: []

  def notifications_type_options
    [
      ['На email и в уведомлениях', 'notifications-email'],
      ['Только уведомления', 'notifications']
    ]
  end

  def paid_functions_options
    [
      ['Закрепить вверху', 'top']
    ]
  end
end
