Giftshare::Application.routes.draw do

  resources :lists do
    resources :products
  end

  resources :friendships
  devise_for :users

  root :to => "welcome#index"
end
