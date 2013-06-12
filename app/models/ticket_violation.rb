# == Schema Information
#
# Table name: ticket_violations
#
#  id           :integer          not null, primary key
#  ticket_id    :integer
#  violation_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class TicketViolation < ActiveRecord::Base
   
   belongs_to :ticket
   belongs_to :violation

end
