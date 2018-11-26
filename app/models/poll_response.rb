class PollResponse < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :poll

  validates :user_id, uniqueness: { scope: :poll_id, message: "your vote has already been recorded" }
end
