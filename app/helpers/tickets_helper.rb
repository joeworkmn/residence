module TicketsHelper

   # TODO Create edit_ticket_link

   def delete_ticket_link(ticket, opts={})
      default_opts = { from: 'edit', method: :delete, data: {confirm: "Really delete?"} }

      opts = from = default_opts.merge(opts)

      opts = from.slice!(:from)

      #link_to("delete", ticket, opts)
      link_to("delete", ticket_path(ticket, from), opts)
   end


   def destroy_ticket_redirect(ticket)
      #path = (request.referer == ticket_url(ticket) || 
      #        request.referer == edit_ticket_url(ticket)) ? tickets_path : :back

      path = (params[:from] == 'edit' || params[:from] == 'show') ? tickets_path : :back

      redirect_to path, notice: "Ticket has been deleted."
   end
end
