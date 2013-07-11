class ScheduleForm
   attr_accessor :month, :year, :interval_length

   def initialize(schedule_month, schedule_year, options={})
      @month = schedule_month
      @year  = schedule_year

      # calling .to_i on nil or a non-number string returns 0
      @interval_length = options[:interval_length].to_i
   end


   def interval_length
      @interval_length = (@interval_length < 1) ? 7 : @interval_length
   end


 
   def submit(schedule_params)
      schedule_params.delete :meta_data

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
         days_of_month.each_slice(interval_length) { |i| intervals << ScheduleRotationInterval.new(i) }

         @intervals = intervals
      end
   end

   def start_of_month
      Date.parse(month)
   end



end
