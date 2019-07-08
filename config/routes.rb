Rails.application.routes.draw do
  get 'home/index'
  get 'movies/:id/actor/:actor_id', to: 'movies#remove_actor', as: :remove_actor
  post 'movies/add_actor', to: 'movies#add_actor', as: :add_actor
  get 'movies/:id/remove_poster/:poster_id', to: 'movies#remove_poster', as: :remove_poster
  get 'movies/remove_trailer/:id', to: 'movies#remove_trailer', as: :remove_trailer
  post 'movies/add_poster', to: 'movies#add_poster', as: :add_poster
  post 'movies/add_trailer', to: 'movies#add_trailer', as: :add_trailer

  devise_for :users

  resources :movies, except: [:index]
  resources :actors

  root to: 'home#index'
end
