require 'test_helper'

class ScheduleEntryTest < ActiveSupport::TestCase
   before do
      @schedule = create(:schedule)
      @entry    = build(:schedule_entry, schedule: @schedule)
   end

   it "Must be valid" do
      @entry.must_be :valid?
   end

   it "Validates date" do
      @entry.date = nil
      @entry.wont_be :valid?
   end

   it "Validates day_or_night" do
      @entry.day_or_night = nil
      @entry.wont_be :valid?
   end

   it "Validates interval_position" do
      @entry.interval_position = nil
      @entry.wont_be :valid?
   end

   it "Validates schedule_id" do
      @entry.schedule_id = nil
      @entry.wont_be :valid?
   end

   it "Validates staff_id" do
      @entry.staff_id = nil
      @entry.wont_be :valid?
   end

   it "Validates shift_id" do
      @entry.shift_id = nil
      @entry.wont_be :valid?
   end

   it "Belongs to a Schedule" do
      @entry.schedule.id.must_equal @schedule.id
      @entry.schedule.must_be :instance_of?, Schedule
   end

   it "Belongs to a Staff" do
      @entry.staff.must_be :instance_of?, Staff
   end

   it "Belongs to a Shift" do
      @entry.shift.must_be :instance_of?, Shift
   end


   describe "#day_shift" do
      it "returns correct records" do
         3.times { create(:schedule_entry, day_or_night: 'day', schedule: @schedule) }
         
         day_shift = @schedule.entries.day_shift
         day_shift.all? { |e| e.day_or_night == 'day' }.must_equal true
      end
   end

   describe "#night_shift" do
      it "returns correct records" do
         3.times { create(:schedule_entry, day_or_night: 'night', schedule: @schedule) }
         
         night_shift = @schedule.entries.night_shift
         night_shift.all? { |e| e.day_or_night == 'night' }.must_equal true
      end
   end
end
