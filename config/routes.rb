# frozen_string_literal: true

Rails.application.routes.draw do
  post '/users', to: 'users#create'
  get '/me', to: 'users#me'
  get 'me/boards', to: 'boards#user_boards'
  post '/auth/login', to: 'auth#login'

  resources :users
  resources :boards do
    resources :sections, shallow: true do
      resources :items, shallow: true
    end
  end
end
