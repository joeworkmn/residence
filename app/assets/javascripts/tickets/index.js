$(document).ready(function() {
   initDataTable()
   checkboxToggle("#select-all-tickets-toggle", ".ticket-checkbox")
   setRansackBooleanFieldValue()
   ransackDateSearches()
})
