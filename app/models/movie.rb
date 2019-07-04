class Movie < ApplicationRecord
  before_save :capitalize_attributes
  validates :title, presence: true, uniqueness: true
  validates :description, :release_date, :genre, presence: true
  validate :attachment_validations

  has_one_attached :thumbnail
  has_one_attached :trailer
  has_many_attached :posters

  private
  def capitalize_attributes
    self.title.capitalize!
    self.genre.capitalize!
  end

  def attachment_validations
    if !thumbnail.attached?
      errors.add(:thumnbail, 'must be present')
    elsif !posters.attached?
      errors.add(:posters, 'must be present')
    elsif !trailer.attached?
      errors.add(:trailer, 'must be present')
    end
  end

end
