Rails.application.routes.draw do
  root 'bracks#index'

  resources :bracks, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :bracks, only: [:index]
    end
  end
end
