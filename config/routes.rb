Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope module: 'merchant' do
        resources :merchants, only: [:index, :show] do
          resources :items, only: [:index]
          resources :invoices, only: [:index]
          collection do
            get 'find', to: 'merchants#show'
            get 'find_all'
            get 'random'
          end
        end
      end
    end
  end
end
