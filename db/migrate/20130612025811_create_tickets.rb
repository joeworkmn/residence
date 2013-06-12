class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
       t.belongs_to :staff
       t.belongs_to :apartment
       t.string     :description
       t.decimal    :total_fine

       t.timestamps
    end
    add_index :tickets, :staff_id
    add_index :tickets, :apartment_id
  end
end
