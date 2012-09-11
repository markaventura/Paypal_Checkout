Billing::Application.routes.draw do
  resources :orders

  get "orders/new/express"

  resources :homes
  resources :order_transactions

  root :to => "orders#index"
end
