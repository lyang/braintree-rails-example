BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards do
        resources :transactions, except: [:edit, :destroy]
        resources :subscriptions
      end
      resources :addresses
      resources :transactions, except: [:edit, :destroy]
    end
  end
  resources :transactions, except: [:edit, :destroy]
  resources :plans, only: [:index, :show] do
    resources :subscriptions
  end
  resources :add_ons, only: [:index, :show]
  resources :discounts, only: [:index, :show]
  resources :subscriptions, except: [:new, :create]
  resources :history_events, only: :index
  root to: 'users#index'
end
