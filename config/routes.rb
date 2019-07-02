Rails.application.routes.draw do
  get 'home/homepage'
  devise_for :users
  resources :movies, except: [:index]
  root to: 'home#homepage'
end
