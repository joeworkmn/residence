class AddIntervalLengthToSchedules < ActiveRecord::Migration
  def change
     add_column :schedules, :interval_length, :integer, default: 0
  end
end
