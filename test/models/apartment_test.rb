require 'test_helper'

class ApartmentTest < ActiveSupport::TestCase

   def setup
      @apartment = FactoryGirl.create(:apartment)
   end

   def invalid_message
      "Apartment was valid when it shouldn't have been."
   end

   # Presence.
   test "should respond to number"  do
      assert @apartment.respond_to? :number, "No method: number"
   end

   test "should respond to password"  do
      assert @apartment.respond_to? :password, "No method: password"
   end

   test "should respond to password_confirmation"  do
      assert @apartment.respond_to? :password_confirmation, "No method: password_confirmation"
   end

   test "should respond to status" do
      assert @apartment.respond_to? :status, "No method: status"
   end

   test "should respond to occupied" do
      assert @apartment.respond_to? :occupied, "No method: occupied"
   end

   test "should respond to occupied?" do
      assert @apartment.respond_to? :occupied?, "No method: occupied?"
   end

   test "should respond to status_start_date" do
      assert @apartment.respond_to? :status_start_date, "No method: status_start_date"
   end

   test "should respond to number_of_tenants" do
      assert @apartment.respond_to? :number_of_tenants, "No method: number_of_tenants"
   end

   test "should respond to tenants" do
      assert @apartment.respond_to? :tenants, "No method: tenants"
   end

   test "should respond to tickets" do
      assert @apartment.respond_to? :tickets, "No method: tickets"
   end



   # Validations. Use shoulda once it works.
   test "should be invalid if no apartment number" do
      @apartment.number = "  "
      refute @apartment.valid?, invalid_message
   end

   test "should be invalid if apartment number is not a number" do
      @apartment.number = "a string"
      refute @apartment.valid?, invalid_message
   end

   test "should be invalid if apartment number already exists" do
      existent_number = @apartment.number
      new_apartment = build(:apartment, number: existent_number)
      refute new_apartment.valid?, invalid_message
   end

   test "should be invalid if no password" do
      apt = build(:apartment, password: "  ")
      refute apt.valid?, invalid_message
   end


   # Nested attributes.
   test "should accept nested attributtes for status" do
      assert @apartment.respond_to? :status_attributes= , "Did not respond to status_attributes="
   end
end
