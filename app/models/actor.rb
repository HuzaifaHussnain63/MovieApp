class Actor < ApplicationRecord
  before_save :capitalize_attributes

  validates :name, presence: true
  validate :attachment_validations

  has_and_belongs_to_many :movies

  has_one_attached :picture

  private
  def capitalize_attributes
    self.name = self.name.titleize
  end

  def attachment_validations
    errors.add(:picture, 'must be present') unless picture.attached?
  end
end
