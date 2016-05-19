Rails.application.routes.draw do

  get 'password_resets/new'

  root to: "pages#splash"

  resources :users, only: [:new, :create, :index, :destroy]
  get "/dashboard", to: "users#dashboard", as: "dashboard"

  post "/cart_items", to: "cart_items#create"
  delete "/cart_items/:id", to: "cart_items#destroy"
  patch "/cart_items/:id", to: "cart_items#update", as: "cart_item"
  get "/cart_items/:id", to: "cart_items#edit", as: "edit_cart_item"

  resources :loan_requests, only: [:index, :create, :new, :edit, :update, :destroy]
  post "/contracts", to: "contracts#create", as: "contracts"
  post "/contracts/:id", to: "contracts#reinstate", as: "reinstate_contract"
  resources :contracts, only: [:new, :destroy, :index]

  get "/:username/loan_requests/", to: "user/loan_requests#index", as: "user_loan_requests"
  get "/:username/loan_requests/:id", to: "user/loan_requests#show", as: "user_loan_request"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/cart", to: "cart_items#index"
  get "/admin/dashboard", to: "admin/users#show"

  resources :loan_offers, except: [:show]

  get ":username/loan_offers", to: "user/loan_offers#index", as: "user_loan_offers"
  get ":username/loan_offers/:id", to: "user/loan_offers#show", as: "user_loan_offer"

  get "/viewloans", to: "pages#viewloans"
  get "/createloan", to: "pages#createloan"
  get "/calculator", to: "pages#calc"
  get "/users/:username", to: "users#show"
  get "/:current_username/contracts", to: "user/contracts#index", as: "user_contracts"

  resources :password_resets, only: [:new, :create, :edit, :update]
  post '/notification' => 'notification#create'

  get "/:category", to: "categories#show"
  post '/notification' => 'notification#create'
  get "/*page", to: "errors#not_found"
end
