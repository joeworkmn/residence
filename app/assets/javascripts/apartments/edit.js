$(document).ready(function() {
   changeStatusStartDateLabel()

   // Occupied? checkbox
   $("body").on('click','#apartment_status_attributes_occupied', function() {
      if (!$(this).is(':checked')) {
         if (confirm("Marking this apartment as VACANT will delete all tickets and tenants associated with this apartment after submitting this form! Continue?") == false) {
            $(this).click()
         }
      }
   })
})
