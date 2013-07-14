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
      ScheduleConfiguration.first.default_interval_length
   end


   def intervals
      @intervals ||= make_intervals
   end


 
   def submit(schedule_params)
      intv_length = schedule_params[:interval_length]
      schedule_params = schedule_params[:entries]
      entries = []
      #binding.pry

      schedule_params.each do |i|
         day_shift = i[1][:day_shift]
         night_shift = i[1][:night_shift]
         entries += make_entries(day_shift) + make_entries(night_shift)
      end

      schedule = Schedule.create(month: month, year: year, interval_length: intv_length, entries: entries)
   end


private

   def make_intervals
      #current_month = Date::MONTHNAMES.index(month)
      #last_month_name = Date::MONTHNAMES[current_month - 1]
      #binding.pry
      #last_months_schedule = ScheduleForm.new(last_month_name)
      #last_int = last_months_schedule.intervals.last.count
      #remaining_days = last_months_schedule.interval_length - last_int

      #first_interval = []
      #remaining_days.times { |n| first_interval << days_of_month.shift }

      #days_of_month.each_slice

      ints = []
      #ints << ScheduleRotationInterval.new(first_interval)


      days_of_month.each_slice(interval_length) { |i| ints << ScheduleRotationInterval.new(i) }
      ints
   end

   def make_entries(time_shift)
      entries = []
      time_shift.each do |ts|
         rec = ts[1]
         rec[:dates].split(',').each do |d|
            entries << ScheduleEntry.new(staff_id: rec[:staff], 
                                         shift_id: rec[:shift], 
                                         day_or_night: rec[:day_or_night],
                                         date: d)
         end
      end
      entries
   end

end
