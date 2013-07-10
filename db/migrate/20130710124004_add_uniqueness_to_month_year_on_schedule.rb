class AddUniquenessToMonthYearOnSchedule < ActiveRecord::Migration
  def change
     add_index :schedules, [:month, :year], unique: true
  end
end
