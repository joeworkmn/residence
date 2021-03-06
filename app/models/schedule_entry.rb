# == Schema Information
#
# Table name: schedule_entries
#
#  id                :integer          not null, primary key
#  date              :date
#  staff_id          :integer
#  shift_id          :integer
#  schedule_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  day_or_night      :string(255)
#  interval_position :integer          default(0)
#

class ScheduleEntry < ActiveRecord::Base
   belongs_to :schedule
   belongs_to :shift
   belongs_to :staff

   delegate :name, :fname, :lname, to: :staff, prefix: true, allow_nil: true
   delegate :name, to: :shift, prefix: true, allow_nil: true

   validates_presence_of :date, :day_or_night, :interval_position, :schedule_id, :shift_id

   scope :night_shift, -> { where(day_or_night: 'night') }
   scope :day_shift, -> { where(day_or_night: 'day') }


   def day_shift?
      day_or_night == 'day'
   end


   def night_shift?
      day_or_night == 'night'
   end
end
