class ChangeTable < ActiveRecord::Migration
  def change
     drop_table :schedule_default_interval_lengths
  end
end
