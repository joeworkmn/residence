class ApartmentsController < ApplicationController

   before_action :set_apartment, only: [:show, :edit, :update]

   def show
   end
   

   def new
      @apartment = Apartment.new(status: ApartmentStatus.new)
   end


   def create
      #abort(apartment_params.to_s)

      if @apartment = Apartment.create!(apartment_params)
         redirect_to @apartment, notice: "Created"
      else
         render :new
      end
   end


   def edit
   end


   def update
      if @apartment.update(apartment_params)
         redirect_to @apartment, notice: "Updated"
      else 
         render 'edit'
      end
   end



   private

   def apartment_params
      params.require(:apartment).permit(:number, status_attributes: [:occupied, :status_start_date, :comment])
   end


   def set_apartment
      @apartment = Apartment.find_by(id: params[:id])
   end
end
