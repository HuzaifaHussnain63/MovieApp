class MovieSerializer < ActiveModel::Serializer
  attributes :title, :description
  has_many :actors
  has_many :reviews

end
