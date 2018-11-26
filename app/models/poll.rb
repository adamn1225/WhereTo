class Poll < ApplicationRecord
  before_create :set_poll_end_time

  belongs_to :user
  has_many :restaurant_polls, dependent: :destroy
  has_many :restaurants, :through => :restaurant_polls
  has_many :dishes, :through => :restaurant_polls
  has_many :poll_responses, dependent: :destroy
  has_many :orders

  def set_poll_end_time
    self.end_time = DateTime.now + 90.seconds
  end

  def winner
    if closed? && poll_responses.any?
      poll_responses
        .group_by{ |pr| pr.restaurant }
        .transform_values{ |v| v.count }
        .max_by{|restaurant, vote_count| vote_count }
        .first
    else
      nil
    end
  end

  def closed?
    DateTime.new < end_time
  end
end
