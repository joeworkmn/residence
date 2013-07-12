require 'test_helper'

class SchedulesPagesTest < ActionDispatch::IntegrationTest
   subject { page }

   describe "New" do
      before do
         visit new_schedule_path
      end

      it "Does NOT initially display Schedule Form." do
         page.wont_have_selector("#schedule-form")
      end

      describe "Initial page" do
         it "Displays defaults" do
            find("#year").value.must_equal(Date.current.year.to_s)
            find("#interval_length").value.must_equal(ScheduleForm.default_interval_length.to_s)
         end
      end

      describe "After selecting meta data for schedule" do
         it "Displays Schedule Form correctly" do
            #binding.pry
            select("July", from: "Select month:")
            fill_in("interval_length", with: "3")
            click_button("Submit")
            sch_form = ScheduleForm.new("July", interval_length: 3)

            page.must_have_selector("#schedule-form")
            first(".interval-range-text").text.must_equal(sch_form.intervals.first.range_text)
            all(".interval-range-text").last.text.must_equal(sch_form.intervals.last.range_text)
            find("#schedule_month").value.must_equal(sch_form.month)
            find("#schedule_year").value.must_equal(sch_form.year.to_s)
         end
      end
   end
end
