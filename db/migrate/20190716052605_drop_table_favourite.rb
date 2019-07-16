class DropTableFavourite < ActiveRecord::Migration[5.2]
  def change
    drop_table :favourites
  end
end
