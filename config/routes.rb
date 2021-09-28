Poly::Engine.routes.draw do
  # Health Check
  resources :ping, only: [:index]

end
