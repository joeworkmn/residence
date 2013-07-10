class SchedulesController < ApplicationController
   def new
      @intervals = ScheduleForm.new("july").intervals
   end


   def create
      binding.pry
   end
end
