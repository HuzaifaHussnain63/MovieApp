class Actor < ApplicationRecord
  before_save :titleize_name

  validates :name, presence: true
  validate :attachment_validations

  has_and_belongs_to_many :movies

  has_one_attached :picture

  validates :picture, presence: true, blob: { content_type: :image }

  paginates_per 5

  private
  def titleize_name
    self.name = self.name.titleize
  end

  def attachment_validations
    errors.add(:picture, 'must be present') unless picture.attached?
  end
end
