class StaffsController < ApplicationController

   before_action :set_staff, only: [:edit, :update, :destroy]

   def index
      @staffs = Staff.all
   end


   def new
      @staff = Staff.new
   end


   def create
      #abort(staff_params[:roles].to_s)

      @staff = Staff.create(staff_params)
      if @staff.valid?
         flash[:success] = "Staff member created."
         redirect_to new_staff_path
      else
         render 'new'
      end
   end


   def edit
   end


   def update
      if @staff.update(staff_params)
         flash[:success] = "Staff member has been updated"
         redirect_to edit_staff_path @staff
      else
         render :edit
      end
   end


   def destroy
      #abort(params[:id].to_s)
      if @staff.remove
         flash.now[:success] = "Staff member has been deleted"
      else
         flash.now[:error] = "Error occured"
      end
   end


   private

   def staff_params
      params.require(:staff)
            .permit(:fname, :lname, :username, :password, 
                    :password_confirmation, :email, :phone_primary, 
                    :phone_secondary, roles: [])
   end


   def set_staff
      @staff = Staff.find_by(id: params[:id])
   end
end
