Rails.application.routes.draw do
  root "application#index"

  get "/index", to: "application#index"
  get "/about", to: "application#about"
  get "/sign_in", to: "users#sign_in"
  
  resources :users
end
