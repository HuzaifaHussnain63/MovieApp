Rails.application.routes.draw do
  get 'home/homepage'
  devise_for :users
  resources :movies
  root to: 'home#homepage'
end
