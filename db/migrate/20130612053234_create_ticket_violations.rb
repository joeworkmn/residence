class CreateTicketViolations < ActiveRecord::Migration
  def change
    create_table :ticket_violations do |t|
       t.belongs_to :ticket
       t.belongs_to :violation


       t.timestamps
    end
  end
end
