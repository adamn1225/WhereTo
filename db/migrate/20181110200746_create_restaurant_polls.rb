class CreateRestaurantPolls < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_polls do |t|
      t.integer :votes
      t.references :poll, foreign_key: true

      t.timestamps
    end
  end
end
