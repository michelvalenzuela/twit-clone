Rails.application.routes.draw do

  
  resources :tweets do
        member do
          post :retweet
          put "like", to: "tweets#like"
          put "dislike", to: "tweets#dislike"
        end
  end
  devise_for :users
  resources :tweets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweets#index"


end
