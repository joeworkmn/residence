class ChangeRolesType < ActiveRecord::Migration
  def change
     change_column :users, :roles, :text, array: true
  end
end
