module SessionsHelper

   def sign_in(account)
      cookies.permanent[:id] = account.id
      self.current_account = account
   end


   def current_account
      @current_account ||= (current_account.instance_of?(User) ? User.find_by(id: cookies[:id]) : Apartment.find_by(id: cookies[:id]))
   end
   

   def current_account=(account)
      @current_account = account
   end


   def sign_out
      current_account = nil
      cookies.delete(:id)
   end
end
