class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.string  :name
      t.decimal :fine

      t.timestamps
    end
  end
end
