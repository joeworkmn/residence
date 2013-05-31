class ChangeStatusOnApartmentStatuses < ActiveRecord::Migration
  def change
     rename_column :apartment_statuses, :since, :status_start_date
  end
end
