class Entities::Profile < Grape::Entity
  expose :id
  expose :name do |e|
    e.user.decorate.name
  end
  expose :email do |e|
    e.user.email
  end
  expose :phone do |e|
    e.user.phone
  end
  expose :photo_url do |e|
    e.user.photo.medium.url
  end
  expose :formatted_price do |e|
    e.decorate.formatted_price
  end
  expose :about
  expose :is_online do |e|
    e.user.decorate.online?
  end
  expose :portfolios, using: Entities::Portfolio
end
