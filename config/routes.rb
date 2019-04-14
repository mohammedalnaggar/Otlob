Rails.application.routes.draw do
  
  #resources :order_details
  resources :orders do
    resources :order_users do
      resources :order_details
    end
  end

  resources :groups
  devise_for :users
  resources :users do
    resources :groups
  end
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  resources :friendships
  
  
  get '/order/:id' => 'orders#finish', :as => :finish_order
  get '/order/:user/:id' => 'order_users#join', :as => :join_order
  root 'welcome#index'
end