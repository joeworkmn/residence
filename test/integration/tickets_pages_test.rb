require 'test_helper'

class TicketsPagesTest < ActionDispatch::IntegrationTest
   subject { page }

   describe "Index" do

      def first_ticket_row
         find("table#tickets").first(".ticket-row")
      end

      js_driver

      before do
         3.times { create(:ticket) }
         visit tickets_path
      end

      it "lists tickets" do
         page.must_have_selector("table#tickets tbody tr", count: 3)
      end

      it "visits tickets#show after clicking details" do
         row1_id = first_ticket_row['id']
         first_ticket_row.click_link("details")
         current_path.must_equal(ticket_path(row1_id.split("_")[1]))
      end

      it "visits tickets#edit after clicking edit" do
         row1_id = first_ticket_row['id']
         first_ticket_row.click_link("edit")
         current_path.must_equal(edit_ticket_path(row1_id.split("_")[1]))
      end

      describe "multi delete" do
         it "deletes selected tickets" do
            before_count = Ticket.count
            rows = all(".ticket-row")
            row1_id = rows[0]['id']
            row2_id = rows[1]['id']
            rows[0].find(".ticket-checkbox").set(true)
            rows[1].find(".ticket-checkbox").set(true)

            click_button("Delete selected")
            confirm_popup
            sleep 1

            page.wont_have_selector(row1_id)
            page.wont_have_selector(row2_id)
            Ticket.count.must_equal(before_count - 2)
         end
      end

      describe "single delete" do
         it "deletes the ticket" do
            before_count = Ticket.count
            row1_id = first_ticket_row['id']
            first_ticket_row.click_link("delete")
            confirm_popup
            sleep 1

            page.wont_have_selector(row1_id)
            Ticket.count.must_equal(before_count - 1)
         end
      end

   end
end
