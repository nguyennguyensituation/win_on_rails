# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#root'
  get '/home', to: 'application#index'
  get '/about', to: 'application#about'

  get '/create_account', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'

  get '/my_account', to: 'users#my_account'

  get '/cancel', to: 'wins#cancel'
  post '/filter', to: 'wins#filter'
  get '/reset_filter', to: 'wins#reset_filter'

  resources :users do
    resources :wins
  end
end
