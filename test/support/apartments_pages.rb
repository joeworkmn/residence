include ApplicationHelper

def fill_in_apartment_form
   fill_in "Number", with: 1001
   fill_in "Password", with: 'password'
   fill_in "Password confirmation", with: 'password'
   fill_in "Password confirmation", with: 'password'
end



################## SHOW ##################

def fill_in_tenant_form
   click_link("Add new tenant")
   fill_in "First Name", with: "John"
   fill_in "Last Name", with: "Doe"
end

def first_tenant_li
   first("ul#tenants li")
end

# Database ID of first tenant in list.
def first_tenant_id
   li_id = first_tenant_li[:id]
   tenant_id = li_id.split("_")[1]
end

def click_relocate
   first_tenant_li.click_link("relocate")
end

def relocate_menu
   first_tenant_li.first(".dropdown-menu")
end

def status_start_date_message_test(status)
   status_start_date = @apartment.status_start_date.to_formatted_s(:long)
   page.must_have_selector("#apartment-status-box p", text: "#{status} since:")
end

########## END SHOW ################
