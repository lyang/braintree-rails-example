BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer do
      resources :credit_cards
      resources :addresses
    end
  end
  root :to => 'users#index'
end
