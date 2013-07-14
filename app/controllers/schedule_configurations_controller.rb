class ScheduleConfigurationsController < ApplicationController
   def index
      @sch_config = ScheduleConfiguration.first
   end

   def update
      ScheduleConfiguration.first.update(schedule_configuration_params)
      flash[:success] = "Schedule options updated."
      redirect_to schedule_configurations_path
   end


   private

   def schedule_configuration_params
      params.require(:schedule_configuration).permit(:default_interval_length)
   end
end
