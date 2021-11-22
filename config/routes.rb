Poly::Engine.routes.draw do
  resources :things
  # Health Check
  resources :ping, only: [:index]

  # Autocomplete
  get 'autocomplete/articles', to: 'autocomplete#articles', as: :article_completion, defaults: {format: :json}
  get 'autocomplete/tags', to: 'autocomplete#tags', as: :tag_completion, defaults: {format: :json}
  get 'autocomplete/users', to: 'autocomplete#users', as: :user_completion, defaults: {format: :json}

  # Application
  get 'articles/tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :comments, only: [:create, :show, :destroy], module: :articles
    resources :reactions, only: [:create, :destroy], module: :articles
  end
  resources :archives
  resources :trash
  resources :users
  resources :settings, only: [:index]

  # API
  namespace :api, defaults: { format: :json } do
    resources :archives, only: [:index]
    resources :trash, only: [:index]

    resources :articles, shallow: true do
      resources :comments, module: :articles
      resources :reactions, module: :articles
    end
    resources :comments
    resources :reactions

    # resources :comments, except: [:create, :destroy] do
    #   resources :reactions, only: [:create, :index], module: :comments
    #   resource :reactions, only: [:destroy], module: :comments
    # end
  end
end
