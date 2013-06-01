class UsersController < ApplicationController
   def new
      @user = User.new
   end


   def create
      #abort(user_params[:roles].to_s)

      @user = User.create(user_params)
      if @user.valid?
         flash[:success] = "User created."
         redirect_to new_user_path
      else
         render 'new'
      end
   end



   private

   def user_params
      params.require(:user)
            .permit(:fname, :lname, :username, :password, roles: [])
   end
end
