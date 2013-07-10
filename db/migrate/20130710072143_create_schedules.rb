class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
       t.integer :year
       t.string  :month

       t.timestamps
    end

    add_index :schedules, :month
    add_index :schedules, :year
  end
end
