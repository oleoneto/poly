Poly::Engine.routes.draw do
  # Health Check
  resources :ping, only: [:index]

  # Application
  resources :archives
  resources :articles, shallow: true do
    resources :comments
    resources :reactions
  end
  resources :trash

  # API
  namespace :v1, defaults: { format: :json } do
    resources :archive, only: [:index]
    resources :comments, except: [:create, :destroy] do
      resources :reactions, only: [:create, :index], module: :comments
      resource :reactions, only: [:destroy], module: :comments
    end
    resources :trash, only: [:index]
  end
end
