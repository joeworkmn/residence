class ScheduleRotationInterval
   attr_accessor :dates

   def initialize(interval_dates)
      check_dates_arg(interval_dates)
      @dates = interval_dates
   end

   def dates=(interval_dates)
      check_dates_arg(interval_dates)
      @dates = interval_dates
   end

   def range_text
      "#{Date::MONTHNAMES[dates.first.month]} #{dates.first.day} - #{Date::MONTHNAMES[dates.last.month]} #{dates.last.day}"
   end


private

   def check_dates_arg(arg)
      raise TypeError, "Argument must be an Array" unless arg.instance_of?(Array)
   end

end
