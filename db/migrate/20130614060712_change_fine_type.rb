class ChangeFineType < ActiveRecord::Migration
  def change
     change_column :violations, :fine, :decimal, default: 0
  end
end
