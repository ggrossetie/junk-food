Auth::Application.routes.draw do

  root to: "sessions#new"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"

  resources :foods
  match "/operations" => "operations#create", :via => :post

  resources :identities

  resources :users

  match "/dashboard", to: "dashboard#index", :as => "dashboard"
end
