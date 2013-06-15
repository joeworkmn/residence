# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  staff_id     :integer
#  apartment_id :integer
#  description  :string(255)
#  total_fine   :decimal(, )      default(0.0)
#  created_at   :datetime
#  updated_at   :datetime
#  paid         :boolean          default(FALSE)
#

class Ticket < ActiveRecord::Base

   default_scope -> { order(updated_at: :desc) }


   belongs_to :staff
   # For counter_cache, if the column isn't the pluralized version of this model (i.e tickets_count),
   # then I would have to specify the column name explicitly.
   belongs_to :apartment, counter_cache: true
   has_many   :ticket_violations
   has_many   :violations, through: :ticket_violations

   validates :violations, presence: { message: "Must select at least one violation." }
   validates :apartment_id, presence: { message: "Must select an apartment." }
   validates :total_fine, numericality: true

end
