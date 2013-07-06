include ApplicationHelper

def confirm_popup
   page.driver.browser.switch_to.alert.accept
end
