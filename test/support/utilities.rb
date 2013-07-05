include ApplicationHelper

def fill_in_apartment_form
   fill_in "Number", with: 1001
   fill_in "Password", with: 'password'
   fill_in "Password confirmation", with: 'password'
   fill_in "Password confirmation", with: 'password'
end

def fill_in_tenant_form
   click_link("Add new tenant")
   fill_in "First Name", with: "John"
   fill_in "Last Name", with: "Doe"
end

def confirm_popup
   page.driver.browser.switch_to.alert.accept
end
