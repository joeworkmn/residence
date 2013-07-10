class CreateScheduleEntries < ActiveRecord::Migration
  def change
    create_table :schedule_entries do |t|
      t.date       :date
      t.belongs_to :staff
      t.belongs_to :shift
      t.belongs_to :schedule

      t.timestamps
    end
  end
end
