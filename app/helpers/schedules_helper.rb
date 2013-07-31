module SchedulesHelper

   def sch_form_month_options
      Schedule.unscheduled_months_for(Time.now.year).map { |m| [m, m] }
   end


   # Returns only day shift entries.
   def day_shift_entries_for(day)
      day.select { |e| e.day_shift? }
   end


   # Returns only night shift entries.
   def night_shift_entries_for(day)
      day.select { |e| e.night_shift? }
   end


   # Displays the label for a particular day in the schedule form
   def schedule_day_label(date)
      Date::DAYNAMES[date.wday] + " " + date.to_formatted_s(:long)
   end


   # Used in #show to display schedule for a single day.
   def schedule_for_day(entries, time_shift)
      html = ""
      entries.each do |e|
         if e.day_or_night == time_shift
            html += content_tag(:u, e.shift_name)
            html += content_tag(:p, e.staff_name, :class => 'assigned-staff')
         end
      end
      raw(html)
   end

end
