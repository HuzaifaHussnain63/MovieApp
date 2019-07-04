class AddIndexToTable < ActiveRecord::Migration[5.2]
  def change
    add_index :actors_movies, :movie_id
    add_index :actors_movies, :user_id
  end
end
