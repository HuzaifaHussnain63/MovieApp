Rails.application.routes.draw do
  get 'users/homepage' , 'users#homepage'
  devise_for :users

  resources :movies
  root to: 'movies#index'

end
