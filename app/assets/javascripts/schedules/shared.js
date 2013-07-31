function changeSchedule() {
   $("#choose-schedule").on('change', 'select', function() {
      id = $(this).val()
      $("#choose-schedule a").prop('href', gon.schedules_path + "/" + id)
   })
}
