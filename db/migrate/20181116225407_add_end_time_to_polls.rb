class AddEndTimeToPolls < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :end_time, :datetime
  end
end
