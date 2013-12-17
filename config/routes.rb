Giftshare::Application.routes.draw do
  devise_for :users

  resources :lists do
    resources :products, except: [:index]
    resources :searches, only: [:create, :show]
    get 'lists/:list_id/searches/:id/next' => 'search#next', :as => "next_page"
    get 'lists/:list_id/searches/:id/previous' => 'search#previous', :as => "previous_page"

  end
  resources :products, only: [:index]
  resources :friendships, only: [:create, :destroy]
  resources :users, controller: :users, only: :show
  resources :activities, only: :index
  
  root :to => "welcome#index"
end
