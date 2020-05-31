Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  devise_for :users

  devise_scope :user do
    get '/user/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: [:show]

  get "/404", :to => "errors#not_found"
  get "/442", :to => "errors#record_not_found"
  get "/500", :to => "errors#internal_server_error"

end