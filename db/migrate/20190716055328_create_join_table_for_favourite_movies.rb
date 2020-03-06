class CreateJoinTableForFavouriteMovies < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :movies, table_name: :favourite_movies
    add_index :favourite_movies, :user_id
    add_index :favourite_movies, :movie_id
  end
end
