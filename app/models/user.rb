class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validates :avatar, presence: true, blob: { content_type: :image }

  has_many :reviews, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_and_belongs_to_many :favourites, class_name: 'Movie', join_table: 'favourite_movies'

  paginates_per 5

  def admin?
    self.admin
  end
end
