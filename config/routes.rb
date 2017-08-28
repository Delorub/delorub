Rails.application.routes.draw do
  # Active admin
  ActiveAdmin.routes(self)

  # API
  mount ApplicationAPI => '/api'

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
  resources :users, only: [:index, :destroy]

  resources :profiles, only: [:show, :edit, :update], path: 'profile'
  resources :profiles, only: [:new, :create]
  resources :profiles, only: [:index] do
    collection do
      get '/:category_id', action: :index, as: :category
    end
  end

  resources :tasks, only: [:show, :edit, :update], path: 'task' do
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
  resources :tasks, only: [:new, :create]
  resources :tasks, only: [:index] do
    collection do
      get '/my(/:category_id)',         action: :index, as: :my,        defaults: { scope: :my }
      get '/suggested(/:category_id)',  action: :index, as: :suggested, defaults: { scope: :suggested }
      get '/:category_id',              action: :index, as: :category
    end
  end

  resources :categories, only: [:index] do
    collection do
      post '/search', action: :search
    end
  end

  resources :deals, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :news, only: [:index, :show]

  resources :help_categories, only: :index, path: 'help', as: :help do
    resources :help_answers, only: :show, path: 'answer', as: :answer
  end
  resources :help_questions, only: [:new, :create], path: 'help'

  resources :vacancies, only: :index

  get 'how-to-master', to: 'custom_pages#how_to_master', as: 'how_to_master'
  get 'how-it-works', to: 'custom_pages#how_it_works', as: 'how_it_works'

  get 'contract_designer/:template_id', to: 'contracts#new', as: :contract_designer

  get '*unmatched_route', to: 'pages#show'
end
