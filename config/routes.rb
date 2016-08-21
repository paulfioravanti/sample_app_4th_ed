Rails.application.routes.draw do
  get "help", to: "pages#show", id: "help"
  get "about", to: "pages#show", id: "about"
  get "contact", to: "pages#show", id: "contact"

  get "signup", to: "users#new"
  post "signup", to: "users#create"

  resources :users

  root "pages#home"
end
