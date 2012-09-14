BraintreeRailsExample::Application.routes.draw do
  resources :users do
    resource :customer
  end
  root :to => 'users#index'
end
