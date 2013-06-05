class RemoveUsernameFromApartments < ActiveRecord::Migration
  def change
     remove_column :apartments, :username
  end
end
