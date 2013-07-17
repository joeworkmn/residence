class AddIntervalPositionToScheduleEntries < ActiveRecord::Migration
  def change
     add_column :schedule_entries, :interval_position, :integer, default: nil
  end
end
