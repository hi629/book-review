Rails.application.routes.draw do
  # resourceful route
  resources :books
  
  root 'books#index'
end
