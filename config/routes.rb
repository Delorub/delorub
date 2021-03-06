Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)

  # API
  mount ApplicationAPI => '/api'

  # sidekiq
  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.permission.superadmin? || user.permission.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  root 'main#index'
  resources :coming_soon_requests, only: [:new, :create], path: '', path_names: {
    new: 'coming-soon',
    create: 'coming-soon'
  } do
    collection do
      post 'main-search', action: :main_search
      get 'coming-soon/thank-you', action: :success, as: :success
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'users/sign_in_as/:type', to: 'users/sessions#sign_in_as', as: :sign_in_as
  end
  resources :users, only: [:index, :destroy]
  resources :delocoins, only: [:new, :create]

  namespace :my do
    resources :welcome, only: :index
    resources :index, only: :index
    resource :user, only: [:edit, :update]
    resource :settings, only: [:edit, :update]
    resources :billing, only: [:index, :create] do
      member do
        get 'confirm', as: :confirm
        post 'confirm'
        get 'status', as: :status
      end
      collection do
        get 'history', as: :history
        resources :yandex_endpoint, path: 'yandex', only: [] do
          get 'success', on: :collection
          match 'fail', via: [:get, :post], on: :collection
        end
      end
    end
    resources :delocoin, only: [:index] do
      collection do
        get 'history', as: :history
      end
    end
  end

  resources :profiles, only: [:show, :edit, :update], path: 'profile'
  resources :profiles, only: [:new, :create]

  resources :tasks, only: [:show, :edit, :update, :destroy], path: 'task' do
    resources :replies, only: [:show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create]
      member do
        get 'cancel_decline'
        get 'decline'
        get 'accept'
        get 'delete'
      end
    end
  end
  resources :tasks, only: [:new, :create], path_names: { new: 'new(/:category_id)' }

  scope '(/:city_code)' do
    resources :tasks, only: [:index] do
      collection do
        get '/my(/:category_id)',         action: :index, as: :my,        defaults: { scope: :my }
        get '/suggested(/:category_id)',  action: :index, as: :suggested, defaults: { scope: :suggested }
        get '/:category_id',              action: :index, as: :category
      end
    end
    resources :profiles, only: [:index] do
      collection do
        get '/:category_id', action: :index, as: :category
      end
    end
  end

  resources :categories, only: [:index]
  resources :deals, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :news, only: [:index, :show]

  resources :help_categories, only: :index, path: 'help', as: :help do
    resources :help_answers, only: :show, path: 'answer', as: :answer
  end
  resources :help_questions, only: [:new, :create], path: 'help'

  resources :vacancies, only: :index

  get '/robots.txt', to: 'main#robots'
  get 'contract_designer/:template_id', to: 'contracts#new', as: :contract_designer

  get '*unmatched_route', to: 'pages#show'
end
