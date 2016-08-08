Rails.application.routes.draw do
  get "home", to: "static_pages#show", id: "home"
  get "help", to: "static_pages#show", id: "help"
  get "about", to: "static_pages#show", id: "about"
  get "contact", to: "static_pages#show", id: "contact"

  root "static_pages#home"
end
