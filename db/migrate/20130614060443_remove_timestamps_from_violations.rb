class RemoveTimestampsFromViolations < ActiveRecord::Migration
  def change
     remove_column :violations, :created_at
     remove_column :violations, :updated_at
  end
end
