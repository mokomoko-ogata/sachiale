Rails.application.routes.draw do
  devise_for :users
  root to: "blogs#index"
  get 'items/search'
  get 'blogs/search'
  resources :blogs do
    resources :comments, only: [:new, :create]
  end
  resources :items
  resources :buys_list, only: [:index, :new, :create, :edit, :update, :destroy]
end
