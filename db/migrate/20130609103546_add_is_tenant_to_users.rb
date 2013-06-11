class AddIsTenantToUsers < ActiveRecord::Migration
  def change
     add_column :users, :is_tenant, :boolean, default: false
  end
end
