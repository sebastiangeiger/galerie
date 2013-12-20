Galerie::Application.routes.draw do
  root to: "home#index"
  devise_for :users, :controllers => {:confirmations => "confirmations"}
  devise_scope :user do
    put "/confirm" => "confirmations#confirm"
  end
  get "home/index"
  get "admin", to: "admin#index"
  namespace :admin do
    resources :users
  end
end
