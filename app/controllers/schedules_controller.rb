class SchedulesController < ApplicationController
   def new
      if month_selected?
         @schedule_form = ScheduleForm.new(params[:month], interval_length: params[:interval_length])
         @intervals     = @schedule_form.intervals
         @guards        = Staff.guards
         @shifts        = Shift.all
      end
   end


   def create
      ScheduleForm.submit(params[:schedule])
   end

private

   def month_selected?
      params[:month] && !params[:month].blank?
   end

   def schedule_params
      params.require(:schedule).permit!
   end

end
