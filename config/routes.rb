BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards do
        member { get :tr_update }
        collection { get :tr_create }
        resources :transactions, :only => :index
      end
      resources :transactions, :except => [:edit, :destroy]
      resources :addresses
    end
  end

  root :to => 'users#index'
end
