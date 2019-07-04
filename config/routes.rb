Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :movies, except: [:index]
  root to: 'home#index'
end
