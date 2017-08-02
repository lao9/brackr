Rails.application.routes.draw do
  root 'bracks#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :bracks, only: [:index, :new, :edit, :update]
  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :bracks, only: [:index, :create]
    end
  end
end
