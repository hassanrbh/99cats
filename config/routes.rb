# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'cats#index'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  get '/lastlogins', to: 'users#last_logins'
  resources :cats, only: %i[index show new create edit update]
  resources :cat_rental_requests, only: %i[new create] do
    member do
      post :approve
      post :deny
    end
  end
  resources :users, only: %i[show new create] do
    member do
      get :last_logins
    end
    resource :cats, only: %i[new index show create]
  end
  resources :sessions, only: %i[new create destroy]
end
