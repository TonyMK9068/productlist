Giftshare::Application.routes.draw do
  devise_for :users


  resources :lists do
    resources :products, except: [:index]
    resources :searches, only: [:create, :show, :previous_page, :next_page]
    get '/searches/:id/next' => 'searches#next', :as => :next
    get '/searches/:id/previous' => 'searches#previous', :as => :previous
  end
  
  resources :messages, only: :create
  resources :products, only: [:index]
  resources :friendships, only: [:create, :destroy]
  resources :users, controller: :users, only: :show
  resources :activities, only: :index
  
  root :to => "welcome#index"
end
