class TenantsController < ApplicationController

   before_action :set_apartment


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


   private

   def tenant_params
      params.require(:tenant)
            .permit(:fname, :lname, :email, :phone_primary, :phone_secondary)
   end

   def set_apartment
      @apartment = Apartment.find_by(id: params[:apartment_id])
   end


end
