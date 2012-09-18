BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards do
        resources :transactions, :except => [:edit, :destroy]
      end
      resources :addresses
      resources :transactions, :except => [:edit, :destroy]
    end
  end
  resources :transactions, :except => [:edit, :destroy]
  root :to => 'users#index'
end
