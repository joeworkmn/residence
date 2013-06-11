class ChangeNameOfTenant < ActiveRecord::Migration
  def change
     rename_column :users, :is_tenant, :tenant
  end
end
