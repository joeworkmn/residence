class ApartmentsController < ApplicationController

   before_action :set_apartment, only: [:show, :edit, :update, :vacate]

   def index
      @apartments = Apartment.all
   end
   

   def show
      @tenants = @apartment.tenants
      @apartments = Apartment.unscoped.order(:number)
      @tickets = @apartment.tickets.includes(:staff)
   end
   

   def new
      @apartment = Apartment.new(status: ApartmentStatus.new)
   end


   def create
      #abort(apartment_params.to_s)
      @apartment = Apartment.create(apartment_params)
      if @apartment.valid?
         flash[:success] = "Apartment has been created"
         redirect_to @apartment
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
      params.require(:apartment)
            .permit(:number, :password, :password_confirmation, status_attributes: [:occupied, :status_start_date, :comment])
   end


   def set_apartment
      @apartment = Apartment.find_by(id: params[:id])
   end
end
