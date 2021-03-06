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

   belongs_to :staff
   # For counter_cache, if the column isn't the pluralized version of this model (i.e tickets_count),
   # then I would have to specify the column name explicitly.
   belongs_to :apartment, counter_cache: true
   has_many   :ticket_violations, dependent: :destroy
   has_many   :violations, through: :ticket_violations

   validates :violations, presence: { message: "Must select at least one violation." }
   validates :apartment_id, presence: { message: "Must select an apartment." }
   validates :staff_id, presence: true
   validates :total_fine, numericality: true

   default_scope -> { order(updated_at: :desc) }
   scope :unpaid, -> { where(paid: false) }

   before_save :calc_total_fine

   def self.ransackable_attributes(auth_object = nil)
      %w(total_fine paid created_at updated_at) + _ransackers.keys
   end


   def calc_total_fine 
      self.total_fine = violations.map { |v| v.fine }.inject(:+)
   end
end
