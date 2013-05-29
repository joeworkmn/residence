class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
       t.integer :number
    end
  end
end
