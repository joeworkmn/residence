class CreateScheduleConfigurations < ActiveRecord::Migration
  def change
    create_table :schedule_configurations do |t|
       t.integer :default_interval_length, default: 0
    end
  end
end
