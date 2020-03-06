class ReportedReview < ApplicationRecord
  validates :review_id, :user_id, presence: true
  validates :review_id, uniqueness: { scope: :user_id }

  belongs_to :review
  belongs_to :user
end
