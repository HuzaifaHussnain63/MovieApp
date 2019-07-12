class AddUniquenessIndexToUserIdAndReviewId < ActiveRecord::Migration[5.2]
  def change
    add_index :reported_reviews, [:user_id, :review_id], unique: true
  end
end
