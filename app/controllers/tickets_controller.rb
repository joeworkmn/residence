class TicketsController < ApplicationController

   def new
      #@ticket = Ticket.new(ticket_violations: TicketViolation.new)
      @ticket = Ticket.new
   end


   def create
      #abort(ticket_params.to_s)
      @ticket = Ticket.create(ticket_params)
      if @ticket.valid?
         abort('hi')
         redirect_to new_ticket_path
      else
         abort('hi')
         render :new
      end
   end

   def edit
      @ticket = Ticket.find_by(id: params[:id])
   end


   def update
      @ticket = Ticket.find_by(id: params[:id])

      if @ticket.update(ticket_params)
         #abort('hi')
         flash[:success] = "Ticket has been updated."
         redirect_to edit_ticket_path(@ticket)
      else
         #abort('hi')
         render :edit
      end
   end


private

   def ticket_params
      params.require(:ticket).permit(:description, violation_ids: [])
   end


end
