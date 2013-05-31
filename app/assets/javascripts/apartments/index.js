$(document).ready(function() {
   initApartmentsDataTable()
})

function initApartmentsDataTable() {
   $("#apartments-data-table").dataTable({
      "bJQueryUI": true,
      "aoColumnDefs": [{ "bSortable": false, "aTargets": ['not-sortable'] }]
   })
}
