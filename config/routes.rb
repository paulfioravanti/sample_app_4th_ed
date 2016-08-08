Rails.application.routes.draw do
  get 'static_pages/home'
  root to: "application#hello"
end
