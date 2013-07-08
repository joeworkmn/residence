class ScheduleForm
   attr_accessor :start_of_month, :intervals 

   def initialize(month)
      @start_of_month = Date.parse(month)
   end

   def intervals
      unless @intervals
         days_in_month = Time.days_in_month(start_of_month.month)

         days_of_month = []
         days_in_month.times { |n| days_of_month << start_of_month.advance(days: n) }

         intervals = []
         days_of_month.each_slice(3) { |i| intervals << i }

         @intervals = intervals
      end
   end
end
