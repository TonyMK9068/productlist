Giftshare::Application.routes.draw do
  devise_for :users

  resources :lists do
    resources :products, except: [:index]
    post '/searches/:id/next' => 'search#next', :as => "next_page", controller: :searches
    post '/searches/:id/previous' => 'search#previous', :as => "previous_page", controller: :searches
    resources :searches, except: [:update, :destroy, :edit, :index]
  end
  
  resources :products, only: [:index]
  resources :friendships, only: [:create, :destroy]
  resources :users, controller: :users, only: :show
  resources :activities, only: :index
  
  root :to => "welcome#index"
end
