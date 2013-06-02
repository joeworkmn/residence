class AddUsernameToApartments < ActiveRecord::Migration
  def change
     add_column :apartments, :username, :string

     add_index :apartments, :username, unique: true
  end
end
