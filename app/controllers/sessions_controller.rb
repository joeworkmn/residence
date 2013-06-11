class SessionsController < ApplicationController
   def new
   end


   def create
      account = if session_params[:tenant]
         Apartment.find_by(number: session_params[:username])
      else
         Staff.find_by(username: session_params[:username])
      end

      if account && account.authenticate(session_params[:password])
         sign_in(account)
         redirect_to home_path, notice: "You have been signed in."
      else
         flash[:error] = "Invalid information"
         render 'new'
      end
   end


   def destroy
      sign_out
      redirect_to root_path, notice: "Signed out"
   end


   private

   def session_params
      params.require(:session).permit(:username, :password, :tenant)
   end

end
