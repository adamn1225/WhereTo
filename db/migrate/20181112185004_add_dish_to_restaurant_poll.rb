class AddDishToRestaurantPoll < ActiveRecord::Migration[5.2]
  def change
    add_reference :restaurant_polls, :dish, foreign_key: true
  end
end
