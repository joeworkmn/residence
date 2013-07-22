class AddMonthNumToSchedules < ActiveRecord::Migration
  def change
     add_column :schedules, :month_position, :integer
  end
end
