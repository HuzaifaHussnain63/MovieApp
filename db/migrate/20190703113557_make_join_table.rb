class MakeJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :movies, :actors
  end
end
