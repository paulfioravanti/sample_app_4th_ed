Rails.application.routes.draw do
  get "home", to: "pages#show", id: "home"
  get "help", to: "pages#show", id: "help"
  get "about", to: "pages#show", id: "about"
  get "contact", to: "pages#show", id: "contact"

  root "pages#home"
end
