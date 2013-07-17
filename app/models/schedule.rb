# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  year            :integer
#  month           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  interval_length :integer          default(0)
#

class Schedule < ActiveRecord::Base
   has_many :entries, class_name: ScheduleEntry, dependent: :destroy

   validates_uniqueness_of :month, scope: :year

   # Returns months that a schedule hasn't been created for yet.
   def self.unscheduled_months
      scheduled_months = Schedule.where(year: Time.now.year).pluck(:month)
      Date::MONTHNAMES - scheduled_months
   end


   def last_interval_length
      entries.select("DISTINCT(date)").where(day_or_night: 'day', interval_position: entries.maximum(:interval_position)).count
   end
end
