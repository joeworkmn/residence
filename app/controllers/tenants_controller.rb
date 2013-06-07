class TenantsController < ApplicationController

   before_action :set_apartment


   def create
      @tenant = @apartment.tenants.create(tenant_params)
      if @tenant.valid?
         @message = {success: "Tenant has been added"}
      end
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
