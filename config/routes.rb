Rails.application.routes.draw do

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
        member do
          post :retweet
          put "like", to: "tweets#like"
          put "dislike", to: "tweets#dislike"
        end
  end
  
  

  devise_for :users
  resources :tweets
  resources :users
  resources :users, only: [:show]
  resources :relationships,       only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweets#index"
  

  get '/tweets/hashtag/:name', to: "tweets#hashtags"
  get '/search', to: "tweets#index"
  

end
