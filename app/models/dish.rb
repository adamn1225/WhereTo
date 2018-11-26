class Dish < ApplicationRecord
  validates :name, presence: true
  belongs_to :restaurant
  has_many :restaurant_polls
  has_many :polls, :through => :restaurant_polls
end
