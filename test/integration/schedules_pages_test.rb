require 'test_helper'

class SchedulesPagesTest < ActionDispatch::IntegrationTest
   subject { page }

   describe "New" do

      describe "Initial page" do
         before do
            create(:schedule_configuration)
            visit new_schedule_path
         end

         it "Does NOT display Schedule Form." do
            page.wont_have_selector("#schedule-form")
         end

         it "Displays default meta data" do
            find("#year").value.must_equal(Date.current.year.to_s)
            find("#interval_length").value.must_equal(ScheduleForm.default_interval_length.to_s)
         end
      end


      describe "After submitting meta data for schedule" do
         let(:sch_month) { "February" }
         let(:sch_year) { "2013" }
         let(:interval_length) { 3 }

         before do
            NewSchedulePage.new(month: sch_month, year: sch_year, intv_len: interval_length).prepare
            @sch_form = ScheduleForm.new(sch_month, year: sch_year, interval_length: interval_length)
         end

         it "Displays Schedule Form" do
            page.must_have_selector("#schedule-form")
         end


         describe "Schedule Form" do
            it "Displays correct interval range text" do
               first(".interval-range-text").text.must_equal(@sch_form.rotation.first.range_text)
               all(".interval-range-text").last.text.must_equal(@sch_form.rotation.last.range_text)
            end

            it "Assigns the correct month and year to hidden fields" do 
               find("#schedule_month").value.must_equal(sch_month)
               find("#schedule_year").value.must_equal(sch_year)
            end
         end

         describe "After submitting Schedule Form" do

            it "Creates a schedule and it's entries in the database" do

               before_sch_count = Schedule.count
               before_entry_count = ScheduleEntry.count
               submit_schedule

               Schedule.count.must_equal(before_sch_count + 1)
               ScheduleEntry.count.must_equal(before_entry_count + expected_entries_created(@sch_form))
               Schedule.last.entries.where(day_or_night: 'night').count.must_equal(expected_entries_created(@sch_form) / 2)
            end

            it "Creates a schedule with the correct attribute values" do
               submit_schedule
               Schedule.last.month.must_equal(sch_month)
               Schedule.last.year.must_equal(sch_year.to_i)
               Schedule.last.interval_length.must_equal(interval_length)
            end

         end

      end
   end # End New


   describe "Edit" do
      #js_driver

      let(:new_schedule_page) { NewSchedulePage.new }

      it "Displays correctly" do
         new_schedule_page.prepare
         submit_schedule 

         schedule = Schedule.last
         entries = schedule.entries.order(:date)

         day_rows = all(".day-row")

         # Test count of day rows.
         day_rows.count.must_equal(31)

         # Test date label for day row.
         day_rows.last.find(".date").text.must_equal(schedule_day_label(entries.last.date))

      end


      it "Populates form fields correctly" do
         guards = new_schedule_page.prepare.fill_in_guards
         submit_schedule

         first(".day-row").find(".day-shift").first("select").value.must_equal(guards.first.id.to_s)
         first(".day-row").find(".day-shift").all("select")[1].value.must_equal(guards[1].id.to_s)
         first(".day-row").find(".day-shift").all("select")[2].value.must_equal(guards[2].id.to_s)

         first(".day-row").find(".night-shift").first("select").value.must_equal(guards[2].id.to_s)
         first(".day-row").find(".night-shift").all("select")[1].value.must_equal(guards[1].id.to_s)
         first(".day-row").find(".night-shift").all("select")[2].value.must_equal(guards.first.id.to_s)

         all(".day-row")[1].find(".day-shift").first("select").value.must_equal(guards.first.id.to_s)
         all(".day-row")[1].find(".day-shift").all("select")[1].value.must_equal(guards[1].id.to_s)
      end

   end # End Edit


   describe "Show" do
      #js_driver

      describe "Content" do

         before do
            @guards = NewSchedulePage.new.prepare.fill_in_guards
            submit_schedule
            @schedule = Schedule.last
            visit schedule_path(@schedule)
         end

         it "Displays correct month and year as the header of page" do
            find("h2#month").must_have_content("#{@schedule.month} #{@schedule.year} Schedule")
         end

         it "Displays assigned staff for the correct days and shifts" do
            work_days = all("td:not(.notmonth)")
            work_days.first.find(".day-shift").first(".assigned-staff").text.must_equal(@guards.first.name)
            work_days.first.find(".day-shift").all(".assigned-staff")[1].text.must_equal(@guards[1].name)
            work_days.first.find(".day-shift").all(".assigned-staff")[2].text.must_equal(@guards[2].name)

            work_days.first.find(".night-shift").first(".assigned-staff").text.must_equal(@guards[2].name)
            work_days.first.find(".night-shift").all(".assigned-staff")[1].text.must_equal(@guards[1].name)
            work_days.first.find(".night-shift").all(".assigned-staff")[2].text.must_equal(@guards.first.name)
            #binding.pry
         end
      end

   end # End Show
end
