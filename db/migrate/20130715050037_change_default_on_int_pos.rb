class ChangeDefaultOnIntPos < ActiveRecord::Migration
  def change
     change_column :schedule_entries, :interval_position, :integer, default: 0
  end
end
