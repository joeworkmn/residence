class AddDayOrNightToScheduleEntries < ActiveRecord::Migration
  def change
     add_column :schedule_entries, :day_or_night, :string
  end
end
