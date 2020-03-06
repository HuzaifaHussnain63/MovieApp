class AddUniquessConstraintToFavouriteMovies < ActiveRecord::Migration[5.2]
  def change
    add_index :favourite_movies, [:user_id, :movie_id], unique: true
  end
end
