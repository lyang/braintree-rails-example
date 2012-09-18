BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards do
        member { get :tr_update }
        collection { get :tr_create }
        resources :transactions, :except => [:edit, :destroy]
      end
      resources :transactions, :except => [:edit, :destroy]
      resources :addresses
    end
  end
  resources :transactions, :except => [:edit, :destroy]
  root :to => 'users#index'
end
