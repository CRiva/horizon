RailsBootstrap::Application.routes.draw do
  devise_for :users
  resources :roles
  resources :articles do
    resources :comments
  end
  root to: 'visitors#new'
end
