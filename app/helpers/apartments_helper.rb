module ApartmentsHelper
   def status_start_date_label(apartment, f)
      if apartment.occupied
         f.label "Occupied since: (yyyy-mm-dd)"
      else
         f.label "Vacant since: (yyyy-mm-dd)"
      end
   end
end
