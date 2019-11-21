Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        collection do
          get 'find', to: 'merchants#show'
          get 'find_all'
          get 'random'
        end
      end
    end
  end
end
