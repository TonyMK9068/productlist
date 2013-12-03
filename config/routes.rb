Giftshare::Application.routes.draw do
  devise_for :users

  resources :lists do
    resources :products
    resources :searches, only: [:create]
  end

  resources :friendships, only: [:create, :destroy]
  resources :users, controller: :users, only: :show

  root :to => "welcome#index"
end
