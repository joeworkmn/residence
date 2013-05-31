class AddDescriptionToApartmentStatuses < ActiveRecord::Migration
  def change
     add_column :apartment_statuses, :comment, :text
  end
end
