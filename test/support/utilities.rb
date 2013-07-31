include ApplicationHelper

def confirm_popup
   page.driver.browser.switch_to.alert.accept
end


def signin_user(user, signin_selector)
   visit signin_path

   within(signin_selector) do
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Sign in"
   end
end


def signin_staff(user)
   signin_user(user, "#staff-signin")
end


def signin_tenant(user)
   signin_user(user, "#tenant-signin")
end
