class ChangeTotalFineType < ActiveRecord::Migration
  def change
     change_column :tickets, :total_fine, :decimal, default: 0
  end
end
