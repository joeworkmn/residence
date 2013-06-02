class AddApartmentsIdToUsers < ActiveRecord::Migration
  def change
     add_column :users, :apartments_id, :integer
  end
end
