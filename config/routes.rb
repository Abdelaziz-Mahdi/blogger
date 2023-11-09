Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show]   do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      get '/page/:page', action: :index, on: :collection
      resources :likes, only: [:create], path: ""
      resources :likes, only: [:destroy], path: ""
      resources :comments, only: [:create, :destroy], path: "comment"
    end
  end
end
