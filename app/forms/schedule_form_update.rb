class ScheduleFormUpdate < ScheduleForm


   def submit(schedule_params)

      entries_params = schedule_params[:entries]

      entries = []

      entries_params.each do |e|
         day_shift = e[1][:day_shift]
         night_shift = e[1][:night_shift]

         day_shift.each do |ds|
            record = ds[1]
            # Update record.
            ScheduleEntry.update(record[:entry_id], staff_id: record[:staff])
         end

         night_shift.each do |ns|
            record = ns[1]
            # Update record.
            ScheduleEntry.update(record[:entry_id], staff_id: record[:staff])
         end
      end

   end

end
