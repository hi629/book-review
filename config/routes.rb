Rails.application.routes.draw do
  devise_for :users
  # resourceful route
  resources :books
  
  root 'books#index'
end
