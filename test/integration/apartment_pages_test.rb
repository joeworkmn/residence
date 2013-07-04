require 'test_helper'

class ApartmentPagesTest < ActionDispatch::IntegrationTest

   subject { page }

=begin Test Javascript drivers
   describe "A JS Driver" do
      js_driver
      before do
         #use_js_driver
         @apartment = create(:apartment, occupied: true)
         visit edit_apartment_path(@apartment)
      end


      # Javascript isn't being processed
      it "tries poltergeist" do
         page.wont_have_selector("#foo-p")
         click_button("foo-btn")
         page.must_have_selector("#foo-p")
      end

      it "foo" do
         page.wont_have_selector("#foo-p")
      end
   end
=end


   describe "Index" do

      before do
         
         3.times { |n| create(:apartment) }
         visit apartments_path
      end

      let(:apartments) { Apartment.all }

      it "has correct content" do
         page.must_have_title("Apartment Index")
         page.must_have_link("edit")
      end


      it "goes to correct edit page after clicking edit link" do
         first_apt = apartments.first
         click_link "edit", href: edit_apartment_path(first_apt)
         current_path.must_equal(edit_apartment_path(first_apt))
      end
   end

   describe "New" do
      before do
         visit new_apartment_path
      end

      it { must_have_title("New Apartment") }

      describe "with invalid information" do

         it "should not create a new apartment" do
            before_count = Apartment.count
            click_button "Submit"

            before_count.must_equal(Apartment.count)
            page.wont_have_selector('div.alert-success')
            page.must_have_title("New Apartment")
         end

      end

      describe "with valid information" do

         it "should create a new apartment" do
            before_count = Apartment.count
            fill_in_apartment_form
            click_button "Submit"

            Apartment.count.must_equal(before_count + 1)
            page.must_have_title('Apartment Status')
            page.must_have_selector('div.alert-success')
         end
      end
   end

   describe "Edit" do
      before do 
         @apartment = create(:apartment) 
         visit edit_apartment_path(@apartment)
      end

      it "should load correct page" do
         current_path.must_equal(edit_apartment_path(@apartment))
      end

      describe "with invalid information" do

         it "should fail to update apartment" do
            invalid_number = " "
            fill_in "Number", with: invalid_number
            click_button "Submit"
            @apartment.reload.number.wont_equal(invalid_number)
            page.must_have_title("Edit Apartment")
         end

      end

      describe "with valid information" do

         it "should update the apartment successfully" do
            new_number = 999999
            fill_in "Number", with: new_number 
            click_button "Submit"

            @apartment.reload.number.must_equal(new_number)
            current_path.must_equal(apartment_path(@apartment))
            page.must_have_selector('div.alert-notice', text: "Updated")
         end

      end
   end

   describe "Show" do

      def status_start_date_message_test(status)
         status_start_date = @apartment.status_start_date.to_formatted_s(:long)
         page.must_have_selector("#apartment-status-box p", text: "#{status} since:")
      end

      let(:tenants_count) { 3 }
      let(:tickets_count) { 2 }

      js_driver

      before do
         @apartment = create(:apartment, tenants_count: tenants_count, tickets_count: tickets_count)
         visit apartment_path(@apartment)
      end

      it "should have correct page and content" do
         current_path.must_equal(apartment_path(@apartment))
         page.must_have_selector("#apartment-status-box p", text: @apartment.comment)
      end

      describe "when apartment is occupied" do
         it "should have correct content on page" do
            page.must_have_selector("#apartment-label h3", text: "Occupied")
            page.must_have_selector("#tenants li", count: tenants_count)
            page.must_have_selector("#tickets tbody tr", count: tickets_count)
            status_start_date_message_test("Occupied")
         end
      end

      describe "when apartment is vacant" do
         before do
            @apartment.occupied = false
            @apartment.save ; @apartment.reload
            visit apartment_path(@apartment)
         end

         it "should have correct content on page" do
            page.must_have_selector("#apartment-label h3", text: "Vacant")
            page.wont_have_selector("#tenants li")
            page.must_have_selector("#tickets tbody tr", 1)
            status_start_date_message_test("Vacant")
         end
      end

      describe "new tenant form" do
         it "does not display new tenant form on page load" do
            page.wont_have_selector("#tenant-form")
         end

         it "displays new tenant form after clicking 'Add new tenant'" do
            click_link("Add new tenant")
            page.must_have_selector("#tenant-form")
         end

         describe "when invalid" do
            it "displays errors on form" do
               click_link("Add new tenant")
               click_button("Add Tenant")

               within("#tenant-form") do
                  page.must_have_selector("span.error", count: 2)
               end
            end
         end

         describe "when valid" do
            it "should create a tenant" do
               before_count = Tenant.count
               fill_in_tenant_form
               click_button("Add Tenant")

               Tenant.count.must_equal(before_count + 1)
            end

            it "displays correct things on page" do
               fill_in_tenant_form
               click_button("Add Tenant")

               page.must_have_selector("ul#tenants li", count: tenants_count + 1)
               within("#tenant-form-message") do
                  page.must_have_selector("div.alert-success", text: "Tenant has been added")
               end 
            end
         end
      end # End new tenant form tests.

      describe "when clicking edit apartment link" do
         it "visits correct apartment edit page" do
            click_link("Edit apartment information")
            current_path.must_equal(edit_apartment_path(@apartment))
         end
      end

   end
end
