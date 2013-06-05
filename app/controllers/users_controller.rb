class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update, :destroy]


   def index
      # Tenants will be separate.
      @users = User.staff
   end


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


   def edit
   end


   def update
      if @user.update(user_params)
         flash[:success] = "User has been updated"
         redirect_to edit_user_path @user
      else
         render :edit
      end
   end


   private

   def user_params
      params.require(:user)
            .permit(:fname, :lname, :username, :password, :password_confirmation, :email, :phone_primary, :phone_secondary, roles: [])
   end


   def set_user
      @user = User.find_by(id: params[:id])
   end
end
