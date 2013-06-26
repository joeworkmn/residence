require 'test_helper'

class ApartmentPagesTest < ActionDispatch::IntegrationTest

   subject { page }

   describe "Index" do

      before do
         5.times { |n| create(:apartment) }
         visit apartments_path
      end

      let(:apartments) { Apartment.all }

      it { must_have_selector('title', text: "Apartments Index") }

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
            it { must_have_selector('h3', text: "Create a new apartment") }
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
            it { must_have_selector('div.alert-success') }
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
            it { must_have_selector("h3", text: "Edit this apartment") }
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
            it "should redirect to show page" do
               current_path.must_equal(apartment_path(@apartment))
            end

            it { must_have_selector('div.alert-notice', text: "Updated") }
         end
      end
   end
end
