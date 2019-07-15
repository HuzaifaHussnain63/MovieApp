class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :reviews, dependent: :destroy
  has_many :reported_reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy

  paginates_per 5

  def admin?
    self.admin
  end
end
