class SchedulesController < ApplicationController


   def index
      @schedules = Schedule.all.order(:year, :month_position)
   end


   def show
      @entries = schedule.entries.order(:date, :shift_id).includes(:shift, :staff)
      @last_months_schedule = schedule.last_months_schedule
      @next_months_schedule = schedule.next_months_schedule
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
      @schedule_form = ScheduleForm::Submission.new(params[:schedule][:month], year: params[:schedule][:year])
      #binding.pry
      if schedule = @schedule_form.submit(params[:schedule])
         redirect_to edit_schedule_path(schedule)
      else
         flash[:error] = "Form is invalid."
         render :new
      end
   end



   def edit
      @entries = schedule.entries.order(:date, :shift_id).includes(:shift)
      @guards = Staff.guards

      @entries_grouped_by_day = @entries.group_by { |e| e.date }.values
   end


   def update
      @schedule_form = ScheduleForm::Update.new(params[:schedule][:month], year: params[:schedule][:year])
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

   def schedule
      @schedule ||= Schedule.find_by(id: params[:id])
   end

   def month_selected?
      params[:month] && !params[:month].blank?
   end

end
