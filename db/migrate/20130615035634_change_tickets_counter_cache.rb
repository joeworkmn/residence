class ChangeTicketsCounterCache < ActiveRecord::Migration
  def change
     change_column :apartments, :tickets_count, :integer, default: 0, null: false
  end
end
