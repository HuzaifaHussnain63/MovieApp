Rails.application.routes.draw do
  get 'home/index'
  get 'reviews/:id/report', to: 'report_reviews#report', as: :report_review
  get 'reported_reviews', to: 'report_reviews#index', as: :reported_reviews
  delete 'reported_review/:id/remove', to: 'report_reviews#delete_reported_review', as: :remove_reported_review

  devise_for :users

  resources :actors, param: :actor_id
  resources :movies do
    resources :reviews, only: [:create, :destroy, :update]

    member do
      delete 'actors/:actor_id/detach_actor', action: :detach_actor, as: :detach_actor_from
      post 'actors/attach_actor', action: :attach_actor, as: :attach_actor_to
    end

    member do
      delete 'posters/:poster_id/remove_poster', action: :remove_poster, as: :remove_poster_from
      delete 'trailers/:trailer_id/remove_trailer', action: :remove_trailer, as: :remove_trailer_from
      post 'posters/add_poster', action: :add_poster, as: :add_poster_to
      post 'trailers/add_trailer', action: :add_trailer, as: :add_trailer_to
    end

  end

  root to: 'home#index'
end
