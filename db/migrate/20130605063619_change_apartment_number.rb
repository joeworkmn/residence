class ChangeApartmentNumber < ActiveRecord::Migration
  def change
     change_column :apartments, :number, :string

     add_index :apartments, :number, unique: true
  end
end
