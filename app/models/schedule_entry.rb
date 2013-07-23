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

   scope :night_shift, -> { where(day_or_night: 'night') }
end
