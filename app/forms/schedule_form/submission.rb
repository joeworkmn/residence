# Handles the submission and creation of new Schedules and associated ScheduleEntries.

class ScheduleForm::Submission < ScheduleForm


   def submit(schedule_params)
      intv_length = schedule_params[:interval_length]
      month_pos = Date::MONTHNAMES.index(month)

      schedule = Schedule.create(month: month, month_position: month_pos, year: year, interval_length: intv_length)
      schedule.entries = make_entries(schedule_params[:entries])

      schedule.valid? ? schedule : false
   end


   # Collects all the entries from the params hash.
   def make_entries(entries_params)
      entries = []

      entries_params.each do |i|
         day_shift = i[1][:day_shift]
         night_shift = i[1][:night_shift]
         entries += parse_timeshift_params_for_entries(day_shift) + parse_timeshift_params_for_entries(night_shift)
      end
      entries
   end


   # Parses the timeshift portion of the params to build each ScheduleEntry for that timeshift.
   def parse_timeshift_params_for_entries(time_shift)
      entries = []
      time_shift.each do |ts|
         rec = ts[1]
         rec[:dates].split(',').each do |d|
            entries << ScheduleEntry.new(staff_id: rec[:staff], 
                                         shift_id: rec[:shift], 
                                         day_or_night: rec[:day_or_night],
                                         date: d,
                                         interval_position: rec[:interval_position])
         end
      end
      entries
   end

end
