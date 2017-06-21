Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)

  # API
  mount ApplicationAPI => '/api'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:index, :destroy]

  resources :profiles, only: [:show, :edit, :update], path: 'profile'
  resources :profiles, only: [:new, :create]
  resources :profiles, only: [:index] do
    collection do
      get '/:category_id', action: :index, as: :category
    end
  end

  resources :tasks, only: [:show, :edit, :update], path: 'task' do
    resources :replies, only: [:show, :create, :update, :destroy] do
      member do
        get 'cancel_decline'
        get 'decline'
        get 'accept'
      end
    end
  end
  resources :tasks, only: [:new, :create]
  resources :tasks, only: [:index] do
    collection do
      get '/my(/:category_id)', action: :index, as: :my, defaults: { scope: :my }
      get '/suggested(/:category_id)', action: :index, as: :suggested, defaults: { scope: :suggested }
      get '/:category_id', action: :index, as: :category
    end
  end

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
