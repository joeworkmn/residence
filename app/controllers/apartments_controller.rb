class ApartmentsController < ApplicationController

   before_action :set_apartment, only: [:show, :edit]

   def show
   end
   

   def new
      @apartment = Apartment.new(status: ApartmentStatus.new)
      #@apartment = Apartment.new
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



   private

   def apartment_params
      params.require(:apartment).permit(:number, status_attributes: [:occupied, :status_start_date, :comment])
      #params.require(:apartment).permit(:number, status: [:occupied, :since])
   end


   def set_apartment
      @apartment = Apartment.find_by(id: params[:id])
   end
end
