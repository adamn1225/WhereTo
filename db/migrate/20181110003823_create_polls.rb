class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.date :date
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
