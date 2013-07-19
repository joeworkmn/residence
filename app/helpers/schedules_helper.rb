module SchedulesHelper

   def sch_form_month_options
      Schedule.unscheduled_months_for(Time.now.year).map { |m| [m, m] }
   end
end
