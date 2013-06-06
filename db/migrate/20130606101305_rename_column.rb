class RenameColumn < ActiveRecord::Migration
  def change
     rename_column :users, :apartments_id, :apartment_id

     add_index :users, :apartment_id
  end
end
