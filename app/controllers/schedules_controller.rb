class SchedulesController < ApplicationController
   def new
      @schedule_form = ScheduleForm.new("july")
      @intervals = @schedule_form.intervals
      @guards    = Staff.guards
      @shifts    = Shift.all
   end


   def create
      ScheduleForm.submit(params[:schedule])
   end

private

   def schedule_params
      params.require(:schedule).permit!
   end

end
