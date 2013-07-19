def expected_entries_created(sch_form)
   # 2 is the amount of time shifts, day and night.
   sch_form.days_in_month * Shift.count * 2
end

def submit_schedule_meta_data(sch_month, sch_year, interval_length)
   select(sch_month, from: "Select month:")
   select(sch_year, from: "Select year:")
   fill_in("interval_length", with: interval_length)
   click_button("Submit")
end
