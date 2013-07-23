module SchedulesHelper

   def sch_form_month_options
      Schedule.unscheduled_months_for(Time.now.year).map { |m| [m, m] }
   end


   def day_shift_entries_for(day)
      day_shift = day.select { |e| e.day_or_night == 'day' }
   end

   def night_shift_entries_for(day)
      night_shift = day.select { |e| e.day_or_night == 'night' }
   end


   def schedule_day_label(date)
      Date::DAYNAMES[date.wday] + " " + date.to_formatted_s(:long)
   end
end
