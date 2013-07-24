class SchedulesController < ApplicationController


   def index
      @schedules = Schedule.all.order(:year, :month_position)
   end


   def new
      if month_selected?
         @schedule_form = ScheduleForm.new(params[:month], year: params[:year], interval_length: params[:interval_length])
         @rotation      = @schedule_form.rotation
         @guards        = Staff.guards
         @shifts        = Shift.all
      end
   end


   def create
      #@schedule_form = ScheduleForm.new(params[:schedule][:month], year: params[:schedule][:year])
      @schedule_form = ScheduleFormSubmission.new(params[:schedule][:month], year: params[:schedule][:year])
      schedule = @schedule_form.submit(params[:schedule])

      redirect_to edit_schedule_path(schedule)
   end



   def edit
      @schedule = Schedule.find_by(id: params[:id])
      @entries = @schedule.entries.order(:date, :shift_id).includes(:shift)
      @guards = Staff.guards

      @entries_grouped_by_day = @entries.group_by { |e| e.date }.values
   end


   def update
      @schedule_form = ScheduleFormUpdate.new(params[:schedule][:month], year: params[:schedule][:year])
      @schedule_form.submit(params[:schedule])

      flash[:success] = "Schedule has been updated"
      redirect_to :back
   end





   # JSON
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
