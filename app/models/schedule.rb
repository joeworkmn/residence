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
#  month_position  :integer
#

class Schedule < ActiveRecord::Base
   has_many :entries, class_name: ScheduleEntry, dependent: :destroy

   validates_presence_of :month, :year, :interval_length, :month_position
   validates_uniqueness_of :month, scope: :year


   after_initialize :capitalize_month



   # Returns months that a schedule hasn't been created for yet.
   def self.unscheduled_months_for(year)
      scheduled_months = Schedule.where(year: year).pluck(:month)
      Date::MONTHNAMES.slice(1,12) - scheduled_months
      #binding.pry
   end


   def last_interval_length
      entries.select("DISTINCT(date)").where(day_or_night: 'day', interval_position: entries.maximum(:interval_position)).count
   end

private

   def capitalize_month
      self.month.capitalize! unless self.month.blank?
   end

end
