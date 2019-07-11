class AddRatingColumnToMovie < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :rating, :float, precision: 1, scale: 1, default: 0.0
  end
end
