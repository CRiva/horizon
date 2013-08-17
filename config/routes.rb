RailsBootstrap::Application.routes.draw do
  resources :articles do
    resources :comments
  end

  root :to => 'visitors#new'
end
