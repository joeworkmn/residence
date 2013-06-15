module ApartmentsHelper
   def status_start_date_label(apartment, f)
      status = apartment.occupied ? "Occupied" : "Vacant"

      content_tag(:label) do
         raw(
            content_tag(:span, status, id: 'status-label') +
            " since: (yyyy-mm-dd)"
         )
      end
   end


   def apartment_label(apartment)
      alert_type = apartment.occupied ? 'alert-info' : 'alert-error'

      content_tag(:div, :class => "span2 text-center alert #{alert_type}") do
         raw(
            content_tag(:h3, apartment.number) +
            content_tag(:h3, apartment.state)
         )
      end
      
   end
end
