# == Schema Information
#
# Table name: violations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  fine       :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class Violation < ActiveRecord::Base

   has_many :ticket_violations
   has_many :tickets, through: :ticket_violations

end
