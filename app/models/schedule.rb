class Schedule < ActiveRecord::Base
   has_many :schedule_entries, dependent: :destroy

   validates_uniqueness_of :month, scope: :year

   # Returns months that a schedule hasn't been created for yet.
   def self.unscheduled_months
      scheduled_months = Schedule.where(year: Time.now.year).pluck(:month)
      Date::MONTHNAMES - scheduled_months
   end
end
