require 'test_helper'

class SchedulesPagesTest < ActionDispatch::IntegrationTest
   subject { page }

   describe "New" do
      before do
         visit new_schedule_path
      end


      describe "Initial page" do
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
         let(:interval_length) { 3 }
         before do
            3.times { |n| create(:shift) }
            select(sch_month, from: "Select month:")
            fill_in("interval_length", with: interval_length)
            click_button("Submit")
            @sch_form = ScheduleForm.new(sch_month, interval_length: interval_length)
         end

         it "Displays Schedule Form" do
            page.must_have_selector("#schedule-form")
         end


         describe "Schedule Form" do
            it "Displays correct interval range text" do
               first(".interval-range-text").text.must_equal(@sch_form.intervals.first.range_text)
               all(".interval-range-text").last.text.must_equal(@sch_form.intervals.last.range_text)
            end

            it "Assigns the correct month and year to hidden fields" do 
               find("#schedule_month").value.must_equal(@sch_form.month)
               find("#schedule_year").value.must_equal(@sch_form.year.to_s)
            end
         end

         describe "After submitting Schedule Form" do
            it "Creates a schedule and it's entries in the database" do
               before_sch_count = Schedule.count
               before_entry_count = ScheduleEntry.count
               click_button "Submit Schedule"

               Schedule.count.must_equal(before_sch_count + 1)
               ScheduleEntry.count.must_equal(before_entry_count + expected_entries_created(@sch_form))
            end
         end

      end
   end
end
