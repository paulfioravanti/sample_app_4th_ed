Rails.application.routes.draw do
  get "sessions/new"

  get "help", to: "pages#show", id: "help"
  get "about", to: "pages#show", id: "about"
  get "contact", to: "pages#show", id: "contact"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  post "signup", to: "users#create"

  resources :users
  resources :account_activations, only: [:edit]

  root "pages#home"
end
