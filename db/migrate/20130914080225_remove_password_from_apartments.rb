class RemovePasswordFromApartments < ActiveRecord::Migration
  def change
     remove_column :apartments, :password_digest
  end
end
