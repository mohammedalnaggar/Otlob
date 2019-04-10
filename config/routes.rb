Rails.application.routes.draw do
  resources :groups
  devise_for :users
  resources :users do
    resources :groups
  end
  get 'welcome/index'

  resources :articles do
    resources :comments
  end


  
  # get '/', { to: 'welcome#index'}
  root 'welcome#index'
end