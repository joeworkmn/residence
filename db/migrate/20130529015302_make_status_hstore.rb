class MakeStatusHstore < ActiveRecord::Migration
  def change
     remove_column :apartments, :status
  end
end
