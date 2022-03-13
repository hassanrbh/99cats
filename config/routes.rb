Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "cats#index"
  get "/signup", to: "users#new"
  get "/signin", to: "sessions#new"
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve
      post :deny
    end
  end
  resources :users, only: [:show ,:new, :create] do 
    resource :cats, only: [:new, :index, :show, :create]
  end
  resource :session, only: [:new, :create, :destroy]
end