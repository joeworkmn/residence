def expected_entries_created(sch_form)
   # 2 is the amount of time shifts, day and night.
   sch_form.days_in_month * Shift.count * 2
end
