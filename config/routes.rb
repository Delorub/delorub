Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)
  
  # API
  mount ApplicationAPI => '/api'
  
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, :only => [:index, :destroy]

  root 'home#index'
end
