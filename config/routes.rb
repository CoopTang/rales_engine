Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope module: 'merchants' do
        resources :merchants, only: [:index, :show] do
          resources :items, only: [:index]
          resources :invoices, only: [:index]
          collection do
            get 'find',     to: 'search#find'
            get 'find_all', to: 'search#find_all'
            get 'random',   to: 'search#random'
          end
        end
      end

      scope module: 'items' do
        resources :items, only: [:index, :show] do
          resource :merchant, only: [:show]
          resources :invoice_items, only: [:index]
          collection do
            get 'find',     to: 'search#find'
            get 'find_all', to: 'search#find_all'
            get 'random',   to: 'search#random'
          end
        end
      end
    end
  end
end
