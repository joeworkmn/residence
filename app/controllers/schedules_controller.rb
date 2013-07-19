class SchedulesController < ApplicationController
   def new
      if month_selected?
         @schedule_form = ScheduleForm.new(params[:month], year: params[:year], interval_length: params[:interval_length])
         @rotation     = @schedule_form.rotation
         @guards        = Staff.guards
         @shifts        = Shift.all
      end
   end


   def create
      @schedule_form = ScheduleForm.new(params[:schedule][:month], year: params[:schedule][:year])
      @schedule_form.submit(params[:schedule])

      redirect_to new_schedule_path
   end


   # JSON API
   def unscheduled_months
      months = Schedule.unscheduled_months_for(params[:year])
      respond_to do |format|
         format.json { render json: months }
      end
   end

private

   def month_selected?
      params[:month] && !params[:month].blank?
   end

end
