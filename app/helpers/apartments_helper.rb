module ApartmentsHelper
   def status_start_date_label(apartment, f)
      #status = apartment.occupied ? "Occupied" : "Vacant"

      content_tag(:label) do
         raw(
            content_tag(:span, apartment.state, id: 'status-label') +
            " since: (yyyy-mm-dd)"
         )
      end
   end


   def apartment_label(apartment)
      alert_type = apartment.occupied ? 'alert-info' : 'alert-error'

      content_tag(:div, id: "apartment-label", :class => "text-center alert #{alert_type}") do
         raw(
            content_tag(:h3, apartment.number) +
            content_tag(:h3, apartment.state)
         )
      end
   end


   def apartment_tickets
      if signed_in_as_staff?
         @apartment.tickets.includes(:staff, :violations)
      else
         @apartment.tickets.unpaid.includes(:staff, :violations)
      end
   end
end
