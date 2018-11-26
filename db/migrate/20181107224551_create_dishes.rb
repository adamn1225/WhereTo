class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.belongs_to :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
