Rails.application.routes.draw do
  root 'bracks#index'

  resources :bracks, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :bracks, only: [:index, :show]
    end
  end
end
