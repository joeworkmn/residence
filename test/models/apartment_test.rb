require 'test_helper'


class ApartmentTest < ActiveSupport::TestCase

   def setup
      @apartment = FactoryGirl.create(:apartment)
   end

   
   # Presence.
   it "should respond to number"  do
      @apartment.must_respond_to :number
   end

   it "should respond to password"  do
      @apartment.must_respond_to :password
   end

   it "should respond to password_confirmation"  do
      @apartment.must_respond_to :password_confirmation
   end

   it "should respond to status" do
      @apartment.must_respond_to :status
   end

   it "should respond to occupied" do
      @apartment.must_respond_to :occupied
   end

   it "should respond to occupied?" do
      @apartment.must_respond_to :occupied?
   end

   it "should respond to status_start_date" do
      @apartment.must_respond_to :status_start_date
   end

   it "should respond to number_of_tenants" do
      @apartment.must_respond_to :number_of_tenants
   end

   it "should respond to tenants" do
      @apartment.must_respond_to :tenants
   end

   it "should respond to tickets" do
      @apartment.must_respond_to :tickets
   end

   it "should respond to state" do
      @apartment.must_respond_to :state
   end

   it "should respond to is?" do
      @apartment.must_respond_to :is?
   end

   # Nested attributes.
   it "should accept nested attributtes for status" do
      @apartment.must_respond_to :status_attributes=
   end


   # Associations
   it "after destroying apartment, associated tenants should be destroyed" do
      apt = create(:apartment, tenants_count: 3)
      apt.destroy
      apt.tenants.size.must_equal(0)
   end

   it "after destroying apartment, associated tickets should be destroyed" do
      apt = create(:apartment, tickets_count: 3)
      apt.reload ; apt.destroy
      apt.tickets.size.must_equal(0)
   end

   # Validations. Use shoulda once it works.
   it "should be invalid if no apartment number" do
      @apartment.number = "  "
      @apartment.wont_be :valid?
   end

   it "should be invalid if apartment number is not a number" do
      @apartment.number = "a string"
      @apartment.wont_be :valid?
   end

   it "should be invalid if apartment number already exists" do
      new_apartment = build(:apartment, number: @apartment.number)
      new_apartment.wont_be :valid?
   end

   it "should be invalid if no password" do
      apt = build(:apartment, password: " ")
      apt.wont_be :valid?
   end

   it "should be invalid if password_confirmation doesn't match password" do
      apt = build(:apartment, password: "password", password_confirmation: "  ")
      apt.wont_be :valid?
   end


   # Call backs.
   it "should delete associated tenants after setting occupied to false" do
      apt = create(:apartment, tenants_count: 3)
      apt.occupied = false
      apt.save
      apt.tenants.size.must_equal(0)
   end

   it "should delete associated tickets after setting occupied to false" do
      apt = create(:apartment, tickets_count: 2)
      apt.occupied = false
      apt.save
      apt.tickets.size.must_equal(0)
   end
   # End Call backs.
   
   
   # Methods
   it "#state should return 'Occupied' if occupied == true" do
      @apartment.state.must_equal("Occupied")
   end

   it "#state should return 'Vacant' if occupied == false" do
      @apartment.occupied = false
      @apartment.state.must_equal("Vacant")
   end

   it "#is?(:tenant) should return true" do
      @apartment.is?(:tenant).must_equal(true)
   end

   it "#is?(:staff) should return false" do
      @apartment.is?(:staff).must_equal(false)
   end
end
