require 'test_helper'

class SchedulesPagesTest < ActionDispatch::IntegrationTest
   subject { page }

   describe "New" do
      before do
         create(:schedule_configuration)
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
         let(:sch_year) { "2013" }
         let(:interval_length) { 3 }
         before do
            3.times { |n| create(:shift) }
            submit_schedule_meta_data(sch_month, sch_year, interval_length)
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
               #3.times { |n| create(:guard) }
               #submit_schedule_meta_data(sch_month, sch_year, interval_length)

               before_sch_count = Schedule.count
               before_entry_count = ScheduleEntry.count
               click_button "Submit Schedule"

               Schedule.count.must_equal(before_sch_count + 1)
               ScheduleEntry.count.must_equal(before_entry_count + expected_entries_created(@sch_form))
               Schedule.last.entries.where(day_or_night: 'night').count.must_equal(expected_entries_created(@sch_form) / 2)
            end

            it "Creates a schedule with the correct attribute values" do
               click_button "Submit Schedule"
               Schedule.last.month.must_equal(sch_month)
               Schedule.last.year.must_equal(sch_year.to_i)
               Schedule.last.interval_length.must_equal(interval_length)
            end

         end

      end
   end
end
