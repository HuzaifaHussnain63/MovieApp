class RemoveRedundentIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :actors_movies, name: 'index_favourite_movies_on_movie_id'
    remove_index :actors_movies, name: 'index_favourite_movies_on_user_id'
  end
end
