class DropRoles < ActiveRecord::Migration
  def change
     remove_column :users, :roles
  end
end
