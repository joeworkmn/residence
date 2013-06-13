# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  staff_id     :integer
#  apartment_id :integer
#  description  :string(255)
#  total_fine   :decimal(, )
#  created_at   :datetime
#  updated_at   :datetime
#

class Ticket < ActiveRecord::Base
   belongs_to :staff
   belongs_to :apartment
   has_many   :ticket_violations
   has_many   :violations, through: :ticket_violations

   validates :violations, presence: { message: "Must select at least one violation." }
   validates :apartment_id, presence: { message: "Must select an apartment." }
   validates :total_fine, numericality: true

end
