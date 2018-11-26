class Restaurant < ApplicationRecord
  validates :name, :address, :city, :state, :zip, presence: true
  has_many :dishes
  has_many :restaurant_polls
  has_many :polls, :through => :restaurant_polls

  def votes_in(poll)
    poll.poll_responses.where(restaurant_id: id).count
  end
end
