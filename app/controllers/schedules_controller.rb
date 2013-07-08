class SchedulesController < ApplicationController
   def new
      start_date = Date.today.beginning_of_month
      days_in_month = Time.days_in_month(start_date.month)

      days_of_month = []
      days_in_month.times { |n| days_of_month << start_date.advance(days: n) }

      intervals = []
      days_of_month.each_slice(3) { |i| intervals << i }

      @intervals = intervals
   end


   def create
      binding.pry
   end
end
