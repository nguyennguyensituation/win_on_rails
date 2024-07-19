Rails.application.routes.draw do
  root "users#index"

  get "/about", to: "users#about"
  get "/sign_in", to: "users#sign_in"
  
  resources :users
end
