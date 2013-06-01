class ChangeUsers < ActiveRecord::Migration
  def change
     change_table :users do |t|
        #t.string :fname
        #t.string :lname
        #t.string :username
        #t.string :password_digest
        #t.string :email
        #t.string :phone_primary
        #t.string :phone_secondary
        t.string :roles, array: true
     end
  end
end
