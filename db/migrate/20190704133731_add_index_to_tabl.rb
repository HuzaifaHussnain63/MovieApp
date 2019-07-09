class AddIndexToTabl < ActiveRecord::Migration[5.2]
  def change
    add_index :actors_movies, :actor_id
  end
end
