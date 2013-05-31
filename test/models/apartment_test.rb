require 'test_helper'

class ApartmentTest < ActiveSupport::TestCase

   def setup
      @apartment = FactoryGirl.create(:apartment)
   end

   test "should respond to number"  do
      assert @apartment.respond_to? :number, "No method: number"
   end

   test "should respond to status" do
      assert @apartment.respond_to? :status, "No method: status"
   end

   test "should respond to occupied" do
      assert @apartment.respond_to? :occupied, "No method: occupied"
   end

   test "should respond to status_start_date" do
      assert @apartment.respond_to? :status_start_date, "No method: status_start_date"
   end

   test "should respond to number_of_tenants" do
      assert @apartment.respond_to? :number_of_tenants, "No method: number_of_tenants"
   end
end
