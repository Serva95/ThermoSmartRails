Rails.application.routes.draw do
  devise_for :users
  root to: 'application#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/404", :to => "errors#not_found"
  get "/442", :to => "errors#record_not_found"
  get "/500", :to => "errors#internal_server_error"

end