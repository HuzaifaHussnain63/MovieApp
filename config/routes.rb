Rails.application.routes.draw do
  get 'home/firstpage'
  devise_for :users
  resources :movies, except: [:index]
  root to: 'home#firstpage'
end
