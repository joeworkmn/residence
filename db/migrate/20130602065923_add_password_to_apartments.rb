class AddPasswordToApartments < ActiveRecord::Migration
  def change
     add_column :apartments, :password_digest, :string
  end
end
