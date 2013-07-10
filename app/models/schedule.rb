class Schedule < ActiveRecord::Base
   has_many :schedule_entries

   validates_uniqueness_of :month, scope: :year
end
