class Movie < ApplicationRecord
  before_save :capitalize_attributes
  validates :title, presence: true, uniqueness: true
  validates :description, :release_date, :genre, presence: true
  validate :attachment_validations

  has_one_attached :thumbnail
  has_one_attached :trailer
  has_many_attached :posters

  has_and_belongs_to_many :actors

  private
  def capitalize_attributes
    self.title.capitalize!
    self.genre.capitalize!
  end

  def attachment_validations
    errors.add(:posters, 'must be present') unless posters.attached?
    errors.add(:trailer, 'must be present') unless trailer.attached?
    errors.add(:thumnbail, 'must be present') unless thumbnail.attached?
  end
end
