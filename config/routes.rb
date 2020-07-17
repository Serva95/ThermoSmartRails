Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'
  devise_for :users, controllers: {sessions:'users/sessions', registrations: 'users/registrations',
                                   passwords:'users/passwords', confirmations: 'users/confirmations'}

  devise_scope :user do
    get '/user/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: [:show]
  resources :rooms, only: [:index, :new, :edit, :create, :update, :destroy, :show] do
    resources :orari_on_offs, only: [:index, :new, :create]
    get "orari_on_off/edit", to: "orari_on_offs#edit"
    patch "orari_on_off/edit", to: "orari_on_offs#update"
    put "orari_on_off/edit", to: "orari_on_offs#update"
    post "temps/:sensor_id/updateTemps", to: "charts#update_temps"
    post "temps/:sensor_id/updateMeds", to: "charts#update_meds"
    get "temps/:sensor_id", as: "temps", to: "temps#room_temps"
    put "manual_active", to: "rooms#manual_active"
    put "manual_inactive", to: "rooms#manual_inactive"
    put "manual_off", to: "rooms#manual_off"
  end
  resources :temps, only: [:index]
  resources :sensors, only: [:index, :new, :edit, :create, :update, :destroy] do
    resources :temps, only: [:create]
  end


  #development.rb config.consider_all_requests_local = false
  get "/404", :to => "errors#not_found"
  get "/442", :to => "errors#record_not_found"
  get "/500", :to => "errors#internal_server_error"

end