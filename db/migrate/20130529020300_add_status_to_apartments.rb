class AddStatusToApartments < ActiveRecord::Migration
  def change
     add_column :apartments, :status, :hstore
  end
end
