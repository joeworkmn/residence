class ScheduleForm
   attr_accessor :month, :intervals

   def initialize(schedule_month)
      @month = schedule_month
   end

   def intervals
      unless @intervals
         days_in_month = Time.days_in_month(start_of_month.month)

         days_of_month = []
         days_in_month.times { |n| days_of_month << start_of_month.advance(days: n) }

         intervals = []
         days_of_month.each_slice(3) { |i| intervals << ScheduleRotationInterval.new(i) }

         @intervals = intervals
      end
   end

   def start_of_month
      Date.parse(month)
   end

end
