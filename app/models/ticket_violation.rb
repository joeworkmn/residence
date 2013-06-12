class TicketViolation < ActiveRecord::Base
   
   belongs_to :ticket
   belongs_to :violation

end
