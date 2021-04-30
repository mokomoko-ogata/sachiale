Rails.application.routes.draw do
  devise_for :users
  root to: "blogs#index"
  resources :blogs
  resources :items
  resources :buys_list, only: [:index, :new, :create]
end
