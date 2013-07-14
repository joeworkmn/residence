class CreateDefaultIntervalLength < ActiveRecord::Migration
  def change
    create_table :schedule_default_interval_lengths do |t|
       t.integer :length, default: 0
    end
  end
end
