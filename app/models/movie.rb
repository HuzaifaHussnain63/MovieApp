class Movie < ApplicationRecord
  before_save :capitalize_attributes
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validate :attachment_validations

  has_one_attached :thumbnail
  has_many_attached :posters
  has_one_attached :trailer

  private
  def capitalize_attributes
    self.title.capitalize!
    self.genre.capitalize!
  end

  def attachment_validations
    if !thumbnail.attached?
      errors.add(:thumnbail, 'must be present')
      return false
    elsif !posters.attached?
      errors.add(:posters, 'must be present')
      return false
    elsif !trailer.attached?
      errors.add(:trailer, 'must be present')
      return false
    else
      return true
    end
  end

end
