Rails.application.routes.draw do
  # Basic routing (home, about)
  root "application#index"

  get "/home", to: "application#index"
  get "/about", to: "application#about"

  get "/create_account", to: "users#new"
  get "/sign_in", to: "sessions#new"
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"

  resources :users, only: [:create, :show]
  # TK win routes
end
