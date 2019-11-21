Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        collection do
          get 'find', to: 'merchants#show'
        end
      end
    end
  end
end
