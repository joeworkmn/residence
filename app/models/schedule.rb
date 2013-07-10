class Schedule < ActiveRecord::Base
   has_many :schedule_entries

   validates :month, uniqueness: true
end
