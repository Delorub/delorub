class Entities::CreateProfileForm < Grape::Entity
  expose :profile_id do |e|
    e.model[:profile].id
  end
  expose :user_id do |e|
    e.model[:user].id
  end

  expose :main_category_id
  expose :categories do |e|
    e.categories.map(&:id)
  end

  expose :certificates, with: Entities::Certificate do |e|
    e.certificates.map(&:model)
  end
  expose :portfolio_items, with: Entities::PortfolioItem do |e|
    e.portfolio_items.map(&:model)
  end

  expose :about

  expose :photo_url do |e|
    if e.temporary_photo_id
      User::TemporaryPhoto.find_by(id: e.temporary_photo_id).photo.upload_preview.url
    else
      e.model[:user].photo.upload_preview.url
    end
  end
  expose :temporary_photo_id

  expose :have_car
  expose :have_instrument
  expose :can_departure
  expose :working_all_time
  expose :working_hours_from
  expose :working_hours_to
  expose :working_days
  expose :working_days_options

  expose :notifications_type
  expose :notifications_type_options

  expose :paid_functions
  expose :paid_functions_options

  expose :price_type
  expose :price_hourly
  expose :price_project
  expose :price_type_options

  expose :place_id
end
