class ScheduleForm
   attr_accessor :month, :year, :interval_length

   def initialize(schedule_month, options={})
      @month = schedule_month

      @year  = options[:year] || Date.current.year
      # calling .to_i on nil or a non-number string returns 0
      @interval_length = options[:interval_length].to_i
   end



   def start_of_month
      Date.parse(month)
   end


   def days_in_month
      Time.days_in_month(start_of_month.month)
   end


   def days_of_month
      days = []
      days_in_month.times { |n| days << start_of_month.advance(days: n) }
      days
   end


   def interval_length
      @interval_length = (@interval_length < 1) ? self.class.default_interval_length : @interval_length
   end


   def self.default_interval_length
      7
   end


   def intervals
      @intervals ||= make_intervals
   end


   def make_intervals
      ints = []
      days_of_month.each_slice(interval_length) { |i| ints << ScheduleRotationInterval.new(i) }
      ints
   end



 
   def submit(schedule_params)
      schedule_params = schedule_params[:entries]

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

end
