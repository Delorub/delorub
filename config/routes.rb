Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, :only => [:index, :destroy]
  #mount RuCaptcha::Engine => "/rucaptcha"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get '/news' => 'home#news_index'
  get '/news/:id' => 'home#news_get'

  get '/create' => 'home#create'
  get '/tasks' => 'task#index'
  get '/tasks/:id' => 'task#get'
  get '/tasks/:id/edit' => 'task#edit'
  post '/set_order' => 'task#set_order'
  post '/task_delete' => 'task#task_delete'
  post '/task_archive' => 'task#task_archive'
  post '/delete_order' => 'task#delete_order'
  post '/change_order' => 'task#change_order'
  post '/change_task' => 'task#change_task'
  post '/edit_order' => 'task#edit_order'

  get '/profile/main_page' => 'profile#main_page'
  get '/profile' => 'profile#index'
  get '/profile/master' => 'profile#master'
  get '/profile/master/answer' => 'profile#master_answer'
  get '/profile/master/inwork' => 'profile#master_inwork'
  get '/profile/master/finish' => 'profile#master_finish'
  get '/profile/master/achive' => 'profile#master_achive'
  get '/profile/settings' => 'profile#settings'
  get '/profile/balance' => 'profile#balance'
  get '/profile/messages' => 'profile#messages'
  get '/profile/messages/orders' => 'profile#messages_orders'
  get '/profile/messages/:id' => 'profile#messages_get'
  get '/profile/master/messages/:id' => 'profile#messages_get_master'
  get '/profile/orders' => 'profile#orders'

  get '/profile/master/settings' => 'profile#settings_master'
  get '/profile/master/balance' => 'profile#balance_master'
  get '/profile/master/messages' => 'profile#messages_master'
  get '/profile/master/messages/orders' => 'profile#master_messages_orders'
  get '/profile/master/messages/:id' => 'profile#messages_get_master'
  get '/profile/master/orders' => 'profile#orders_master'
  

  post '/profile/save' => 'profile#save'
  post '/profile/message' => 'profile#message'
  post '/profile/message_order' => 'profile#message_order'
  get '/profile/step1' => 'profile#step1'
  post '/profile/step2_1' => 'profile#step2_1'
  post '/profile/step2_2' => 'profile#step2_2'
  post '/profile/step2_3' => 'profile#step2_3'
  post '/profile/step2_4' => 'profile#step2_4'
  post '/profile/step2_5' => 'profile#step2_5'
  post '/profile/step_3' => 'profile#step3'
  post '/profile/answer/save' => 'profile#answer_save'
  post '/answer_remove' => 'profile#answer_remove'
  post '/set_user_type' => 'profile#set_user_type'
  post '/profile/recall' => 'profile#recall'
  post '/message_delete' => 'profile#message_delete'

  get '/city-serach' => 'home#city_serach'
  get '/status' => 'home#status'
  get '/kak-eto-rabotaet' => 'home#kak_eto_rabotaet'
  get '/questions' => 'home#questions'
  get '/blank' => 'home#blank'

  get '/cats' => 'maincat#index'
  get '/cat/:id' => 'maincat#get'

  get '/users/:id' => 'users#get'
  post '/like' => 'users#like'
  post '/new_user_reg' => 'users#new_user_reg'
  post '/new_user' => 'users#new_user'


  post '/create-task' => 'home#create_task'
  post '/get_notify' => 'home#get_notify'
end
