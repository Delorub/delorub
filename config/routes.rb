Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, :only => [:index, :destroy]
  #mount RuCaptcha::Engine => "/rucaptcha"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
end
