require 'test_helper'

class ApartmentPagesTest < ActionDispatch::IntegrationTest
   test "title of page" do
      visit apartments_path
      assert page.has_content?("Apartments")
   end
end
