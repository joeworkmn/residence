class AddTicketsCountToApartments < ActiveRecord::Migration
  def change
     add_column :apartments, :tickets_count, :integer, default: 0
  end
end
