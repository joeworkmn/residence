class ChangeType < ActiveRecord::Migration
  def change
     change_column :apartment_statuses, :status_start_date, :date
  end
end
