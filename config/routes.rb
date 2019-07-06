Rails.application.routes.draw do
  get 'home/index'
  get 'movies/:id/actor/:actor_id', to: 'movies#remove_actor', as: :remove_actor
  devise_for :users
  resources :movies, except: [:index]
  resources :actors
  root to: 'home#index'
end
