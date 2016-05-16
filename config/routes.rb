Rails.application.routes.draw do

  root to: "pages#splash"

  # get '/items', to: 'items#index'
  # get '/items/:id', to: 'items#show', as: 'item'

  resources :users, only: [:new, :create, :index, :show, :destroy]
  get "/dashboard", to: "users#dashboard", as: 'dashboard'

  post '/cart_items', to: 'cart_items#create'
  delete '/cart_items/:id', to: 'cart_items#destroy'
  patch '/cart_items/:id', to: 'cart_items#update', as: 'cart_item'
  get '/cart_items/:id', to: 'cart_items#edit', as: 'edit_cart_item'

  resources :loan_requests, only: [:index, :create, :new, :edit, :update, :destroy]
  post '/contracts', to: 'contracts#create', as: 'contracts'
  resources :contracts, only: [:new]

  get '/:username/loan_requests/', to: 'user/loan_requests#index', as: 'user_loan_requests'
  get '/:username/loan_requests/:id', to: 'user/loan_requests#show', as: 'user_loan_request'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/cart", to: "cart_items#index"
  get "/admin/dashboard", to: "admin/users#show"

  resources :loan_offers, except: [:show]

  get ':username/loan_offers', to: 'user/loan_offers#index', as: 'user_loan_offers'
  get ':username/loan_offers/:id', to: 'user/loan_offers#show', as: 'user_loan_offer'

  get "/viewloans", to: "pages#viewloans"

  get '/:current_username/contracts', to: 'user/contracts#index', as: 'user_contracts'

  get "/createloans", to: "pages#createloans"
  get "/:category", to: "categories#show"
  # get "/*page", to: "errors#not_found"
end
