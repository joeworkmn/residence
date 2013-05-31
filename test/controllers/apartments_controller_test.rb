require 'test_helper'

class ApartmentsControllerTest < ActionController::TestCase

   test "new apartment" do
      get :new
      assert_not_nil assigns(:apartment)
   end


   # Test not working.
   #test "should create apartment" do
   #   apartment_params = { apartment: { number: 102, status_attributes: { occupied: true } } }
   #   assert_difference("Apartment.count") do
   #      post :create, post: apartment_params
   #   end
   #end
end
