Rails.application.routes.draw do
  root 'bracks#index'

  namespace :api do
    namespace :v1 do
      resources :bracks, only: [:index]
    end
  end
end
