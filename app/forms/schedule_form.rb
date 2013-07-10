class ScheduleForm
   attr_accessor :month, :intervals

   def initialize(schedule_month)
      @month = schedule_month
   end

   def self.submit(schedule_params)
      month = schedule_params.delete :month
      year  = Time.now.year


      entries = []
      schedule_params.each do |i|
         i[1].each do |sh|
            rec = sh[1]

            rec[:dates].split(",").each do |d|
               entries << ScheduleEntry.new(staff_id: rec[:staff], shift_id: rec[:shift], date: d)
            end

         end
      end

      schedule = Schedule.create(month: month, year: year, schedule_entries: entries)

      #binding.pry
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
