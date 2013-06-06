class TenantsController < ApplicationController

   before_action :set_apartment


   def create
      #@abort(params.to_s)

      @tenant = @apartment.tenants.create(tenant_params)
      abort(@tenant.valid?.to_s)
      if @tenant.valid?
         flash[:success] = "Tenant has be added."
         redirect_to @apartment
      else 
         render @apartment
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
