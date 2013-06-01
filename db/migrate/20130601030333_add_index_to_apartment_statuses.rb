class AddIndexToApartmentStatuses < ActiveRecord::Migration
  def change
     add_index :apartment_statuses, :apartment_id
  end
end
