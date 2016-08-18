Rails.application.routes.draw do
  get "help", to: "pages#show", id: "help"
  get "about", to: "pages#show", id: "about"
  get "contact", to: "pages#show", id: "contact"

  get "signup", to: "users#new"

  resources :users

  root "pages#home"
end
