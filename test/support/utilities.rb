include ApplicationHelper

def confirm_popup
   page.driver.browser.switch_to.alert.accept
end


def signin_user(user)
   visit signin_path

   within("#staff-signin") do
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Sign in"
   end
end
