module SessionsHelper

   def sign_in(account)
      cookies.permanent[:id] = account.id

      if account.instance_of?(Staff)
         cookies.permanent[:signed_in_as_staff?] = true
      else
         cookies.permanent[:signed_in_as_tenant?] = true
      end

      self.current_account = account

      # Only staff can have multiple roles and has a current_role method.
      if signed_in_as_staff?
         self.current_account.current_role = current_account.roles.first 
         current_account.save
      end
   end


   def current_account
      @current_account ||= signed_in_as_staff? ? Staff.find_by(id: cookies[:id]) : Apartment.find_by(id: cookies[:id])
   end
   

   def current_account=(account)
      @current_account = account
   end


   def signed_in_as_staff?
      cookies[:signed_in_as_staff?] ? true : false
   end


   def signed_in_as_tenant?
      cookies[:signed_in_as_tenant?] ? true : false
   end

   def sign_out
      current_account = nil
      cookies.delete(:id)
      cookies.delete(:signed_in_as_staff?) #if signed_in_as_staff?
      cookies.delete(:signed_in_as_tenant?) #if signed_in_as_tenatn?
   end
end
