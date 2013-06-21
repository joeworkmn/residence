$(document).ready(function() {
   $.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' })
})


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
      "aoColumnDefs": [
                       { "bSortable": false, "aTargets": ['not-sortable'] },
                       { "sType": "num-html", "aTargets": ['num-html'] },
                       { "sType": "currency", "aTargets": ['currency-column'] }
                      ]
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


// toggle == the id of the toggle.
// checkboxes == the class of the checkboxes to be checked.
function checkboxToggle(toggle, checkboxes) {
   $("body").on('click', toggle, function() {
      toggle = $(toggle)
      if (toggle.is(":checked")) {
         $(checkboxes).prop("checked", true)
      } else {
         $(checkboxes).prop("checked", false)
      }
   })
}


// Deletes a DataTables row.
function deleteDTRow(rowID) {
   // Must use .get(0) because jquery returns an array of rows, 
   // but fnDeleteRow expects a single row.
   row = $("tr#" + rowID).get(0)
   $(".data-table-gem").dataTable().fnDeleteRow(row)
}


function setRansackBooleanFieldValue() {
   $(".search-conditions .predicate-select").on('change', function() {

      val = $(this).val()
      if (val == "true") {
         $(this).next().val("true")
      } else if (val == "false") {
         $(this).next().val("false")
      } 
   })
}


function ransackDateSearches() {
   attrSelects = $(".attribute-select")
   $.each(attrSelects, function() {
      setDatePickerIfDateType( $(this) )
   })

   $(".search-conditions .attribute-select").on('change', function() {
      setDatePickerIfDateType( $(this) )
   })
}


// Attaches datepicker if the Ransack selected attribute is a date type (i.e. matches one of dateAttrs)
function setDatePickerIfDateType(attrSelect) {

   dateAttrs = ["created_at", "updated_at"]

   if ( $.inArray(attrSelect.val(), dateAttrs) != -1 ) {
      attrSelect.next().next().datepicker()
   } else {
      attrSelect.next().next().datepicker("destroy")
   }
}
