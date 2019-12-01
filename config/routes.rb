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

      scope module: 'invoice_items' do
        resources :invoice_items, only: [:index, :show] do
          resource :item, only: [:show]
          resource :invoice, only: [:show]
          collection do
            get 'find',     to: 'search#find'
            get 'find_all', to: 'search#find_all'
            get 'random',   to: 'search#random'
          end
        end
      end

      scope module: 'transactions' do
        resources :transactions, only: [:index, :show] do
          resource :invoice, only: [:show]
          collection do
            get 'find',     to: 'search#find'
            get 'find_all', to: 'search#find_all'
            get 'random',   to: 'search#random'
          end
        end
      end

      scope module: 'customers' do
        resources :customers, only: [:index, :show] do
          resources :invoices, only: [:index]
          resources :transactions, only: [:index]
          collection do
            get 'find',     to: 'search#find'
            get 'find_all', to: 'search#find_all'
            get 'random',   to: 'search#random'
          end
        end
      end

      scope module: 'invoices' do
        resources :invoices, only: [:index, :show] do
          resources :transactions, only: [:index]
          resources :items, only: [:index]
          resources :invoice_items, only: [:index]
          resource :customer, only: [:show]
          resource :merchant, only: [:show]
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
