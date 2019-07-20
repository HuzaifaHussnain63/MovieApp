class ActorsMovie < ApplicationRecord
  validates :actor_id, uniqueness: { scope: :movie_id }
end
