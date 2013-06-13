function changeStatusStartDateLabel() {    
   $("body").on('click',"#apartment_status_attributes_occupied", function() { 
      if ($(this).is(':checked')) {
         $("#status-label").text("Occupied")
      } else {
         $("#status-label").text("Vacant")
      }
   })
}

function initDataTable(selector = '.data-table-gem') {
   $(selector).dataTable({
      "bJQueryUI": true,
      "aoColumnDefs": [{ "bSortable": false, "aTargets": ['not-sortable'] }]
   })
}


function calcTicketsTotalFine() {
   $("body").on('click', ".violation", function() {

      violations = $(".violation:checked")

      totalFine = 0
      $.each(violations, function() {
         totalFine += parseFloat($(this).data('fine'))
      })

      $("#ticket_total_fine").val(totalFine)
   })
}
