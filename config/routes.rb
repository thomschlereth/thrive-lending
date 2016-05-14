Rails.application.routes.draw do

  root to: "pages#splash"

  # resources :items, only: [:index, :show]
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show', as: 'item'

  get '/users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create', as: 'users'

  # resources :cart_items, only: [:edit]
  post '/cart_items', to: 'cart_items#create'
  delete '/cart_items/:id', to: 'cart_items#destroy'
  patch '/cart_items/:id', to: 'cart_items#update', as: 'cart_item'
  get '/cart_items/:id', to: 'cart_items#edit', as: 'edit_cart_item'

  # resources :orders, only: [:index, :create]
  get '/orders', to: 'orders#index', as: 'orders'
  post '/orders/', to: 'orders#create'

  resources :loan_requests, only: [:index, :create, :new, :edit, :update, :destroy]



  get    '/:username/loan_requests/', to: 'user/loan_requests#index', as: 'user_loan_requests'
  # get    '/:username/loan_requests/:id/edit', to: 'user/loan_requests#edit', as: 'edit_user_loan_request'
  get    '/:username/loan_requests/:id', to: 'user/loan_requests#show', as: 'user_loan_request'



  # namespace admin, resources items, resources users, only show
  get    '/admin/items', to: 'admin/items#index', as: 'admin_items'
  post   '/admin/items', to: 'admin/items#create'
  get    '/admin/items/new', to: 'admin/items#new', as: 'new_admin_item'
  get    '/admin/items/:id/edit', to: 'admin/items#edit', as: 'edit_admin_item'
  get    '/admin/items/:id', to: 'admin/items#show', as: 'admin_item'
  patch  '/admin/items/:id', to: 'admin/items#update'
  delete '/admin/items/:id', to: 'admin/items#destroy'
  get    '/admin/users/:id', to: 'admin/users#show', as: 'admin_user'
  get "/order", to: "orders#show"
  get "/dashboard", to: "users#show", as: 'dashboard'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/cart", to: "cart_items#index"
  get "/admin/dashboard", to: "admin/users#show"

  resources :loan_offers, except: [:show]

  get ':username/loan_offers', to: 'user/loan_offers#index', as: 'user_loan_offers'
  get ':username/loan_offers/:id', to: 'user/loan_offers#show', as: 'user_loan_offer'


  get "/viewloans", to: "pages#viewloans"
  get "/createloans", to: "pages#createloans"
  get "/:category", to: "categories#show"
  # get "/*page", to: "errors#not_found"
end
