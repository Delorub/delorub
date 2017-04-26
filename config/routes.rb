Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)

  # API
  mount ApplicationAPI => '/api'

  devise_for :users

  resources :users, only: [:index, :destroy]
  resources :profile, only: [:new, :create]
  resources :task

  resources :news, only: [:index, :show]

  resources :vacancies, only: :index

  resources :help_categories, only: :index, path: 'help', as: :help do
    resources :help_answers, only: :show, path: 'answer', as: :answer
  end
  resources :help_questions, only: [:new, :create], path: 'help'

  root 'main#index'

  get 'contract_designer/:template_id', to: 'contracts#new', as: :contract_designer

  get '*unmatched_route', to: 'pages#show'
end
