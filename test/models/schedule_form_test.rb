require 'test_helper'

class ScheduleFormTest < ActiveSupport::TestCase
   let(:last_month) { "June" }
   let(:month) { "July" }
   let(:interval_length) { 3 }
   let(:sch_form) { ScheduleForm.new(month, interval_length: interval_length) }

   describe "Initialize" do
      it "Only accepts valid months" do
         -> { ScheduleForm.new('invalid') }.must_raise(ArgumentError)
      end

      it "It is not case sensitive when checking the month" do
         assert_nothing_raised do
            ScheduleForm.new('jaNUAry')
         end
      end

      it "Uses current year if no year is specified" do
         sch_form.year.must_equal(Date.current.year)
      end

      it "Uses passed in year" do
         form_with_specified_year = ScheduleForm.new(month, year: 2001)
         form_with_specified_year.year.must_equal(2001)
      end
   end

   describe "Interval length" do
      before { create(:schedule_configuration) }

      it "Must equal passed in value when present" do
         sch_form.interval_length.must_equal(interval_length)
      end

      it "Must use default length if no length was passed" do 
         ScheduleForm.new(month).interval_length.must_equal(sch_form.class.default_interval_length)
      end

      it "Must use default length if invalid integer was passed" do 
         ScheduleForm.new(month, interval_length: 'foo').interval_length.must_equal(sch_form.class.default_interval_length)
      end

      it "Must use default length if length is less than or equal to zero" do 
         ScheduleForm.new(month, interval_length: 0).interval_length.must_equal(sch_form.class.default_interval_length)
         ScheduleForm.new(month, interval_length: -3).interval_length.must_equal(sch_form.class.default_interval_length)
      end
   end

   describe "Start of month" do
      it "Must be the first day of the month" do
         sch_form.start_of_month.must_equal(Date.parse(month))
      end
   end

   describe "Days of month" do
      it "Returns an array of all days in the month" do
         days_of_month = sch_form.days_of_month
         days_of_month.must_be :instance_of?, Array
         days_of_month.length.must_equal(sch_form.days_in_month)
         days_of_month.first.must_equal(sch_form.start_of_month)
         days_of_month.last.must_equal(sch_form.start_of_month.advance(days: sch_form.days_in_month - 1))
      end
   end

   describe "Making the schedules intervals" do

      describe "Carry over from last month's rotation" do

         it "Must have a first interval that contains the rest of the days from the previous month's last interval" do
            create(:schedule_configuration)
            last_schedule = create(:schedule, month: last_month)
            sch_form.stubs(:last_months_schedule).returns(last_schedule)
            last_schedule.stubs(:last_interval_length).returns(3)

            carry_over = last_schedule.interval_length - last_schedule.last_interval_length
            sch_form.intervals.first.dates.count.must_equal(carry_over)
            sch_form.intervals[2].dates.count.must_equal(sch_form.interval_length)
         end
      end
   end


end
