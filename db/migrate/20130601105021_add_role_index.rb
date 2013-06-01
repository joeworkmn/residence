class AddRoleIndex < ActiveRecord::Migration
  def change
     add_index :users, :roles
  end
end
