Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts
  resources :users

  get '/registration', to: 'users#new', as: :registration
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  namespace :user do
    get '/dashboard', to: 'dashboard#show'
  end
end
