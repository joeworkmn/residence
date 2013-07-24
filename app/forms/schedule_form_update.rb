# Handles the submission of edited Schedules and associated ScheduleEntries.

class ScheduleFormUpdate < ScheduleForm

   def submit(schedule_params)
      entries_params = schedule_params[:entries]

      entries_params.each do |e|
         day_shift = e[1][:day_shift]
         night_shift = e[1][:night_shift]

         update_entries_for(day_shift)
         update_entries_for(night_shift)
      end

   end


   # Parses the time shift portion of the params and updates the ScheduleEntry records.
   def update_entries_for(time_shift)
      time_shift.each do |ts|
         record = ts[1]
         # Update record.
         ScheduleEntry.update(record[:entry_id], staff_id: record[:staff])
      end
   end
end
