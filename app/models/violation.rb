# == Schema Information
#
# Table name: violations
#
#  id   :integer          not null, primary key
#  name :string(255)
#  fine :decimal(, )      default(0.0)
#

class Violation < ActiveRecord::Base

   has_many :ticket_violations
   has_many :tickets, through: :ticket_violations

   validates_presence_of :name
   validates :fine, numericality: true

end
