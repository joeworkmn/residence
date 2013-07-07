require 'test_helper'

class TicketTest < ActiveSupport::TestCase
   before { @ticket = build(:ticket) }

   subject { @ticket }

   it "must be valid" do
      @ticket.must_be :valid?
   end

   it "must respond to correct attributes" do
      @ticket.must_respond_to :staff_id
      @ticket.must_respond_to :apartment_id
      @ticket.must_respond_to :description
      @ticket.must_respond_to :total_fine
      @ticket.must_respond_to :paid?
      @ticket.must_respond_to :staff
      @ticket.must_respond_to :apartment
      @ticket.must_respond_to :ticket_violations
      @ticket.must_respond_to :violations
   end

   it "must have correct associations" do
      @ticket.save
      @ticket.staff.class.must_equal Staff
      @ticket.apartment.class.must_equal Apartment

      @ticket.violations.class.must_equal ActiveRecord::Associations::CollectionProxy::ActiveRecord_Associations_CollectionProxy_Violation
      @ticket.violations.count.must_be :>=, 1
   end

   it "must validate violations" do
      @ticket.violations = []
      @ticket.wont_be :valid?
   end

   it "must validate apartment" do
      @ticket.apartment_id = nil
      @ticket.wont_be :valid?
   end

   it "must validate staff" do
      @ticket.staff_id = nil
      @ticket.wont_be :valid?
   end

   it "must validate total_fine" do
      # Test numericality
      @ticket.total_fine = "foo"
      @ticket.wont_be :valid?
      @ticket.total_fine = 5.0
      @ticket.must_be :valid?
   end

   describe "unpaid scope" do
      it "should only return unpaid tickets" do
         2.times { create(:ticket, paid: true) }
         create(:ticket, paid: false)
         Ticket.unpaid.count.must_equal(1)
      end
   end
end
