Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)

  # API
  mount ApplicationAPI => '/api'

  devise_for :users

  resources :users, only: [:index, :destroy]
  resources :news, only: [:index]

  root 'main#index'

  get 'contract_designer/:template_id', to: 'contracts#new', as: :contract_designer

  get '*unmatched_route', to: 'page_not_found#index' unless Rails.env.development?
end
