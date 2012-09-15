BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards do
        resources :transactions, :only => :index
      end
      resources :addresses
      resources :transactions, :except => [:edit, :destroy]
    end
  end
  root :to => 'users#index'
end
