class RemoveIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :actors_movies, name: 'index_actors_movies_on_user_id'
  end
end
