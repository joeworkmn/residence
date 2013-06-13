class TicketsController < ApplicationController

   def new
      #@ticket = Ticket.new(ticket_violations: TicketViolation.new)
      @ticket = Ticket.new
   end


   def create
      # Want to keep track of who created the ticket so do it through association.
      @ticket = current_account.tickets.create(ticket_params)
      if @ticket.valid?
         flash[:success] = "Ticket has been created."
         redirect_to new_ticket_path
      else
         render :new
      end
   end


   def edit
      @ticket = Ticket.find_by(id: params[:id])
   end


   # Any manager or guard can update ticket.
   def update
      @ticket = Ticket.find_by(id: params[:id])

      if @ticket.update(ticket_params)
         flash[:success] = "Ticket has been updated."
         redirect_to edit_ticket_path(@ticket)
      else
         render :edit
      end
   end


private

   def ticket_params
      params.require(:ticket).permit(:description, :apartment_id, :total_fine, violation_ids: [])
   end


end
