# == Schema Information
#
# Table name: schedule_configurations
#
#  id                      :integer          not null, primary key
#  default_interval_length :integer          default(0)
#

class ScheduleConfiguration < ActiveRecord::Base
end
