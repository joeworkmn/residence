class AddPublishedToSchedules < ActiveRecord::Migration
  def change
     add_column :schedules, :published, :boolean, default: false
  end
end
