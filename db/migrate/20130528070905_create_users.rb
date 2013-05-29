class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
       t.string :fname
       t.string :lname
       t.string :username
       t.string :password_digest
       t.string :email
       t.string :phone_primary 
       t.string :phone_secondary
       t.string :type
    end

    add_index :users, :username, unique: true
    add_index :users, :type
  end
end
