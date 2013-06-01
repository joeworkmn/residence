class SessionsController < ApplicationController
   def new
   end


   def create
      user = User.find_by(username: session_params[:username])
      if user && user.authenticate(session_params[:password])
         redirect_to home_path, notice: "You have been signed in."
      else
         flash[:error] = "Invalid information"
         render 'new'
      end
   end


   def destroy
   end


   private

   def session_params
      params.require(:session).permit(:username, :password)
   end

end
