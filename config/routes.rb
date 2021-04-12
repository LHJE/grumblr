Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts
  post '/posts/new', to: 'posts#new'

  resources :users
  post '/users/:id/edit', to: 'users#edit'

  get '/registration', to: 'users#new', as: :registration
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  get '/follower_followed/:id/create', to: 'follower_followed#create'
  get '/follower_followed/:id/destroy', to: 'follower_followed#destroy'

  get '/user_likes/:id/create', to: 'user_likes#create'
  get '/user_likes/:id/destroy', to: 'user_likes#destroy'

  namespace :user do
    get '/dashboard', to: 'dashboard#show'
    get '/liked/:id', to: 'liked#show'
  end
end
