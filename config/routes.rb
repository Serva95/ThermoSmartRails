Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  devise_for :users, controllers: {sessions:'users/sessions', registrations: 'users/registrations',
                                   passwords:'users/passwords', confirmations: 'users/confirmations'}

  devise_scope :room do
    get '/user/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: [:show]
  resources :rooms, only: [:index, :new, :edit, :create, :update, :destroy, :show]
  resources :temps, only: [:index, :show]
  resources :sensors, only: [:index, :new, :edit, :create, :update, :destroy]


  #development.rb config.consider_all_requests_local = false
  get "/404", :to => "errors#not_found"
  get "/442", :to => "errors#record_not_found"
  get "/500", :to => "errors#internal_server_error"

end