include ApplicationHelper

def fill_in_apartment_form
   fill_in "Number", with: 1001
   fill_in "Password", with: 'password'
   fill_in "Password confirmation", with: 'password'
   fill_in "Password confirmation", with: 'password'
end
