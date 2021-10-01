Poly::Engine.routes.draw do
  # Health Check
  resources :ping, only: [:index]

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
