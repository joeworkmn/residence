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
         5.times { |n| create(:apartment) }
         visit apartments_path
      end

      let(:apartments) { Apartment.all }


      it { must_have_title("Apartment Index") }

      it { must_have_link("edit") }


      it "should go to correct edit page after clicking edit link" do
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
         before do
            @before_count = Apartment.count
            click_button "Submit"
         end

         it "should not create a new apartment" do
            @before_count.must_equal(Apartment.count)
         end

         describe "page" do
            it { wont_have_selector('div.alert-success') }
            it { must_have_title("New Apartment") }
         end

      end

      describe "with valid information" do
         before do
            @before_count = Apartment.count
            fill_in_apartment_form
            click_button "Submit"
         end

         it "should create a new apartment" do
            Apartment.count.must_equal(@before_count + 1)
         end

         describe "page" do
            it { must_have_title('Apartment Status') }
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
         let(:invalid_number) { "" }

         before do
            fill_in "Number", with: invalid_number
            click_button "Submit"
         end

         it "should fail to update apartment" do
            @apartment.reload.number.wont_equal(invalid_number)
         end

         describe "page" do
            it { must_have_title("Edit Apartment") }
         end
      end

      describe "with valid information" do
         let(:new_number) { 999999 }

         before do
            fill_in "Number", with: new_number
            click_button "Submit"
         end

         it "should update the apartment" do
            @apartment.reload.number.must_equal(new_number)
         end

         describe "page" do
            it "should redirect to #show page" do
               current_path.must_equal(apartment_path(@apartment))
            end

            it { must_have_selector('div.alert-notice', text: "Updated") }
         end
      end
   end

   describe "Show" do

      def status_start_date_message_test(status)
         status_start_date = @apartment.status_start_date.to_formatted_s(:long)
         page.must_have_selector("#apartment-status-box p", text: "#{status} since: #{status_start_date}")
      end

      let(:tenants_count) { 3 }
      let(:tickets_count) { 2 }

      before do
         @apartment = create(:apartment, tenants_count: tenants_count, tickets_count: tickets_count)
         visit apartment_path(@apartment)
      end

      describe "new tenant form" do
      end

      it "should have correct path" do
         current_path.must_equal(apartment_path(@apartment))
      end

      it "should have correct comment" do
         page.must_have_selector("#apartment-status-box p", text: @apartment.comment)
      end

      describe "when apartment is occupied" do

         it { must_have_selector("#apartment-label h3", text: "Occupied") }

         it { must_have_selector("#tenants li", count: tenants_count) }

         it { must_have_selector("#tickets tbody tr", count: tickets_count) }

         describe "status box" do

            it "should have correct status start date message" do
               status_start_date_message_test("Occupied")
            end
         end
      end

      describe "when apartment is vacant" do
         before do
            @apartment.occupied = false
            @apartment.save ; @apartment.reload
            visit apartment_path(@apartment)
         end

         it { must_have_selector("#apartment-label h3", text: "Vacant") }

         it { wont_have_selector("#tenants li") }

         it { wont_have_selector("#tickets tbody tr") }

         describe "status box" do

            it "should have correct status start date message" do
               status_start_date_message_test("Vacant")
            end

         end

      end
   end
end
