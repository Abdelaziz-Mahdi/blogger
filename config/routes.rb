Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#login'
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

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