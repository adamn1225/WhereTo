class AddRestaurantToRestaurantPoll < ActiveRecord::Migration[5.2]
  def change
    add_reference :restaurant_polls, :restaurant, foreign_key: true
  end
end
