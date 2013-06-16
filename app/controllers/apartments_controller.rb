class ApartmentsController < ApplicationController


   def index
      @apartments = Apartment.all
   end
   

   def show
      @tenants = apartment.tenants
      @apartments = Apartment.unscoped.order(:number)
      @tickets = apartment_tickets
   end
   

   def new
      @apartment = Apartment.new(status: ApartmentStatus.new)
   end


   def create
      @apartment = Apartment.create(apartment_params)
      if @apartment.valid?
         flash[:success] = "Apartment has been created"
         redirect_to @apartment
      else
         render :new
      end
   end


   def edit
      apartment
   end


   def update
      if apartment.update(apartment_params)
         redirect_to apartment, notice: "Updated"
      else 
         render 'edit'
      end
   end



   private

   def apartment_params
      params.require(:apartment)
            .permit(:number, :password, :password_confirmation, status_attributes: [:occupied, :status_start_date, :comment])
   end

   def apartment
      @apartment = Apartment.find_by(id: params[:id])
   end

end
