module TicketsHelper

   def delete_ticket_link(ticket, opts={})
      default_opts = { from: 'edit', method: :delete, data: {confirm: "Really delete?"} }
      opts = from = default_opts.merge(opts)

      # from keeps the slice, opts gets the rest.
      opts = from.slice!(:from)
      link_to("delete", ticket_path(ticket, from), opts)
   end


   # Since a ticket can be deleted from multiple views, we want to redirect
   # to the correct view after destroying the ticket.
   def destroy_ticket_redirect(ticket)
      path = (params[:from] == 'edit' || params[:from] == 'show') ? tickets_path : :back

      redirect_to path, notice: "Ticket has been deleted."
   end


   def after_ticket_destroyed
      if request.xhr?
         set_deleted_tickets_flash_now
      else
         # redirect to appropriate action
         destroy_ticket_redirect(ticket)
      end
   end


   def set_deleted_tickets_flash_now
      flash.now[:notice] = "Tickets have been deleted."
   end
end
