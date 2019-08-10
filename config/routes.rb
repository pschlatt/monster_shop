Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :merchants do
    resources :items, only: :index
  end

  resources :items do
    resources :reviews, only: [:create]
  end

  get '/items', to: "items#index"
  get '/items/:id', to: "items#show"
  get '/items/:id/edit', to: "items#edit"
  patch '/items/:id', to: "items#update"
  delete '/items/:id', to: "items#destroy"


  get '/items/:item_id/reviews/new', to: "reviews#new", as: "new_item_review"


  get '/reviews/:id/edit', to: "reviews#edit", as:"edit_review"
  patch '/reviews/:id', to: "reviews#update"
  delete '/reviews/:id', to: "reviews#destroy", as: "review"

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'



  get '/users/new', to: 'users#new'
  get '/register', to: 'users#register'
  get '/profile', to: 'users#show', as: 'profile'
  post '/profile', to: 'users#create'
  get '/profile/edit', to: 'users#edit', as: 'edit_profile'
  get '/profile/edit_password', to: 'users#edit_password', as: 'edit_password'
  put 'profile/', to: 'users#update'
  patch 'profile/', to: 'users#update_password', as: 'update_password'
  get 'profile/orders', to: 'orders#index', as: 'profile_orders'
  get 'profile/order/:id', to: 'orders#show', as: 'profile_order'
  post '/profile/orders', to: 'orders#create', as: 'create_order'
  patch 'profile/order/:id', to: 'orders#update', as: 'update_profile_order'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create', as: 'user_login'
  get '/logout', to: 'sessions#destroy'

  namespace :merchant do
    get '/dashboard', to: 'dashboard#index', as: 'dashboard'
    get '/', to: 'dashboard#show', as: 'dashboard_show'
    get '/:id/items', to: 'items#index'
    patch 'items/:id/activate', to: 'items#activate', as: 'activate'
    patch 'items/:id/deactivate', to: 'items#deactivate', as: 'deactivate'
    get '/orders/:order_id', to: 'orders#show', as: 'orders_show'
    patch '/orders/:order_items_id', to: 'orders#update', as: 'item_fulfill'
    get '/items', to: 'items#index', as: 'items_index'
    get '/items/new', to: 'items#new'
    get '/items/:id/edit', to: 'items#edit', as: 'items_edit'
    patch '/items', to: 'items#update'
    post '/items', to: 'items#create'
    delete 'items/:id', to: 'items#destroy', as: 'item_delete'
  end

  namespace :admin do
    get '/users', to: "users#index", as: 'all_users'
    get '/users/:id', to: "users#show"
    get '/dashboard', to: 'dashboard#index', as: :dashboard
    get '/merchants/:id', to: "merchants#show", as: 'merchants_show'
    get '/merchants', to: "merchants#index"
    put '/merchants/:id', to: 'merchants#disable', as: :disable
    patch '/merchants/:id', to: 'merchants#enable', as: :enable
    patch '/orders/:id', to: 'orders#update', as: 'order_ship'
  end
end
