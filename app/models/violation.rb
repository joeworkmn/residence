class Violation < ActiveRecord::Base

   has_many :ticket_violations
   has_many :tickets, through: :ticket_violations

end
