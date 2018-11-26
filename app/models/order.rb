class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :poll

  validates :user_id, uniqueness: { scope: :poll_id }
end
