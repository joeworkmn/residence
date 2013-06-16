module TicketsHelper

   # TODO Create edit_ticket_link

   def delete_ticket_link(ticket, label="delete")
      link_to(label, ticket, method: :delete, data: { confirm: "Really delete?" })
   end


   def destroy_ticket_redirect(ticket)
      path = (request.referer == ticket_url(ticket) || 
              request.referer == edit_ticket_url(ticket)) ? tickets_path : :back

      redirect_to path, notice: "Ticket has been deleted."
   end
end
