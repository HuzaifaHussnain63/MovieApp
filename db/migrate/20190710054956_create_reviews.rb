class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :status
      t.references :movie
      t.references :user
      t.timestamps
    end
  end
end
