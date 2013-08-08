$(document).ready(function() {
   initDataTable()
   checkboxToggle("#select-all-tickets-toggle", ".ticket-checkbox")
   setRansackBooleanFieldValue()
   ransackDateSearches()

   $('#search-form').on('click', '.remove_condition', function(event) {
      $(this).closest('.search-condition').remove()
      event.preventDefault()
   })

   $('#search-form').on('click', '.add_condition', function(event) {
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()
   })
})
