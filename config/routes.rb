Giftshare::Application.routes.draw do
  resources :lists


  devise_for :users

  resources :lists do
    resources :products, except: [:index]
    resources :searches, only: [:create]
  end
  resources :products, only: [:index]
  resources :friendships, only: [:create, :destroy]
  resources :users, controller: :users, only: :show

  root :to => "welcome#index"
end
