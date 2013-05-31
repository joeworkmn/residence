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
end
