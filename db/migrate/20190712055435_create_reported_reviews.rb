class CreateReportedReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reported_reviews do |t|
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
  end
end
