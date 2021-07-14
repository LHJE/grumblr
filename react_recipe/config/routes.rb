Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get 'grumbls/index'
      post 'grumbls/create'
      get '/show/:id', to: 'grumbls#show'
      delete '/destroy/:id', to: 'grumbls#destroy'
    end
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'

end
