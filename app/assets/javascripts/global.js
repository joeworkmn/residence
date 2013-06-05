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
