require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
   before  { @schedule = build(:schedule) }


   it "Must be valid" do
      @schedule.must_be :valid?
   end

   it "Validates presence of month" do
      @schedule.month = nil
      @schedule.wont_be :valid?
   end

   it "Validates presence of year" do
      @schedule.year = nil
      @schedule.wont_be :valid?
   end

   it "Validates presence of interval_length" do
      @schedule.interval_length = nil
      @schedule.wont_be :valid?
   end

   it "Validates presence of month_position" do
      @schedule.month_position = nil
      @schedule.wont_be :valid?
   end

   it "Validates month/year uniqueness" do
      @schedule.save
      dup_schedule = build(:schedule)
      dup_schedule.wont_be :valid?
   end


   it "Has many entries" do
      schedule_with_entries = create(:schedule_with_entries) 

      schedule_with_entries.must_respond_to :entries
      schedule_with_entries.entries.count.must_equal(3)
   end


   describe "Schedule::unscheduled_months_for(year)" do

      it "Only returns months that a schedule has not been created for yet" do
         # Because @schedule hasn't been saved yet.
         Schedule.unscheduled_months_for(2013).include?(@schedule.month).must_equal(true)

         @schedule.save
         Schedule.unscheduled_months_for(2013).include?(@schedule.month).must_equal(false)
      end

   end
   
end
