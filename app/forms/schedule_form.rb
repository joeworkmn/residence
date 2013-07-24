class ScheduleForm

   attr_accessor :month, :year, :interval_length, :rotation

   def initialize(schedule_month, options={})
      raise ArgumentError, "Invalid month." unless Date::MONTHNAMES.include? schedule_month.capitalize

      @month = schedule_month.capitalize
      @year  = options[:year] || Date.current.year

      # calling .to_i on nil or a non-number string returns 0
      @interval_length = options[:interval_length].to_i
   end


   def year
      @year.to_i
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


   def rotation
      @rotation ||= make_rotation
   end


   def last_months_schedule
      @last_months_schedule ||= Schedule.find_by(month: last_months_name, year: last_months_year)
   end

 
private

   #########################################################
   ############# Rotation Helpers ##########################
   #########################################################

   # Creates the rotation to display on the new form.
   def make_rotation
      ints = []

      # If a schedule for last month was created.
      ints += carry_over_from_last_month if last_months_schedule
      
      # If ints is empty, return all days of month. Otherwise return 
      # days_of_month minus whatever days were added to the first interval
      # based on the carry over from last month's schedule.
      remaining_days = ints.blank? ? days_of_month : days_of_month - ints.first.dates

      remaining_days.each_slice(interval_length) { |i| ints << ScheduleRotationInterval.new(i) }
      ints
   end


   # Determines if there's any carry over from last month's final rotation interval and uses those
   # days to create the first interval of this month.
   def carry_over_from_last_month
      days = days_of_month
      ints = []
      carry_over = last_months_schedule.interval_length - last_months_schedule.last_interval_length
      if carry_over > 0
         first_interval = []
         carry_over.times { first_interval << days.shift }
         ints << ScheduleRotationInterval.new(first_interval)
      end
      ints
   end


   def last_months_name
      current_month = Date::MONTHNAMES.index(month)
      current_month = (january?) ? 13 : current_month
      last_months_name = Date::MONTHNAMES[current_month - 1]
   end


   def last_months_year
      (january?) ? year - 1 : year
   end

   
   def january?
      month == "January"
   end
   
end
