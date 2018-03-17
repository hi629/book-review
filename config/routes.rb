Rails.application.routes.draw do
  devise_for :users
  # resourceful route
  resources :books do
    resources :reviews
  end
  
  root 'books#index'
end
