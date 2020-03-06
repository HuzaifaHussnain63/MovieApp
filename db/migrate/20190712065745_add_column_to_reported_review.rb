class AddColumnToReportedReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reported_reviews, :movie_id, :integer
  end
end
