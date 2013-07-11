class SchedulesController < ApplicationController
   def new
      if month_selected?
         @schedule_form = ScheduleForm.new(params[:month], params[:year], interval_length: params[:interval_length])
         @intervals     = @schedule_form.intervals
         @guards        = Staff.guards
         @shifts        = Shift.all
      end
   end


   def create
      @schedule_form = ScheduleForm.new(params[:schedule][:month], params[:schedule][:year])
      @schedule_form.submit(params[:schedule])
   end

private

   def month_selected?
      params[:month] && !params[:month].blank?
   end

end
