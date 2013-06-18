class TicketsController < ApplicationController

   def index
      @tickets = Ticket.all.includes(:staff, :apartment, :violations)
   end


   def show
      ticket
   end


   def new
      @ticket = Ticket.new
   end


   def create
      # Want to keep track of who created the ticket so do it through association.
      @ticket = current_user.tickets.create(ticket_params)
      if @ticket.valid?
         flash[:success] = "Ticket has been created."
         redirect_to new_ticket_path
      else
         render :new
      end
   end


   def edit
      ticket
   end


   # Any manager or guard can update ticket.
   def update
      if ticket.update(ticket_params)
         flash[:success] = "Ticket has been updated."
         redirect_to edit_ticket_path(ticket)
      else
         render :edit
      end
   end


   def destroy
      result = ticket.destroy
      if result.destroyed?
         destroy_ticket_redirect(ticket)
      else
         redirect_to :back, error: "Error occured. Ticket has not been deleted."
      end
   end


private

   def ticket_params
      params.require(:ticket).permit(:description, :apartment_id, :total_fine, :paid, violation_ids: [])
   end


   def ticket
      @ticket ||= Ticket.find_by(id: params[:id])
   end


end
