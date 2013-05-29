class CreateApartmentStatuses < ActiveRecord::Migration
  def change
    create_table :apartment_statuses do |t|
       t.boolean :occupied
       t.date :since
       t.integer :number_of_tenants

       t.integer :apartment_id
    end
  end
end
