require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments
  end
  get 'search', to: 'search#search'
  resources :users do
    get :followers, :followees
  end
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  mount Sidekiq::Web => '/sidekiq'
end
