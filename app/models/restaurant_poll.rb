class RestaurantPoll < ApplicationRecord
  belongs_to :poll
  belongs_to :restaurant
  belongs_to :dish, optional: true
end
