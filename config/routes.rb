Galerie::Application.routes.draw do
  root to: "home#index"
  devise_for :users
  get "home/index"
  get "admin", to: "admin#index"
  namespace :admin do
    resources :users
  end
end
