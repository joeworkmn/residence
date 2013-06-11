class TenantsController < ApplicationController

   before_action :set_apartment
   before_action :set_tenant, only: [:promote_to_staff_form]


   def create
      @apartments = Apartment.unscoped.order(:number)
      @tenant = @apartment.tenants.create(tenant_params)
      if @tenant.valid?
         @message = {success: "Tenant has been added"}
      end
   end


   def destroy
      tenant = @apartment.tenants.find_by(id: params[:id])
      tenant.destroy
   end


   def relocate
      # TODO relocate action: When I add feature to allow managers to own their own apartments...
      # TODO make sure to do this through the managers association.
      
      @tenant = @apartment.tenants.find_by(id: params[:id])
      @tenant.apartment_id = params[:new_apartment_id]
      if @tenant.save
         flash[:success] = "Tenant has been relocated." 
      else 
         flash[:error] = "Error occured."
      end
      redirect_to @apartment
   end


   def promote_to_staff_form
      # Unscope because the user is still a tenant at this point.
      @tenant = Staff.unscoped.find_by(id: params[:id])
   end

   def promote_to_staff
      # Find through Staff because I want the validations for staff fields.
      # Unscope because the user is still a tenant at this point.
      @tenant = Staff.unscoped.find_by(id: params[:id])

      if @tenant.update(promote_to_staff_params)
         redirect_to promote_to_staff_form_tenant_path(@tenant), notice: "Tenant has been added to staff."
      else 
         render 'promote_to_staff_form'
      end
   end

   private

   def tenant_params
      params.require(:tenant)
            .permit(:fname, :lname, :email, :phone_primary, :phone_secondary)
   end


   def promote_to_staff_params
      params.require(:staff)
            .permit(:username, :password, :password_confirmation, roles: [])
   end

   def set_apartment
      @apartment = Apartment.find_by(id: params[:apartment_id])
   end


   def set_tenant
      @tenant = Tenant.find_by(id: params[:id])
   end
end
