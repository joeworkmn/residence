module Schedulable
   extend ActiveSupport::Concern

   included do
   end



   def last_months_schedule
      @last_months_schedule ||= Schedule.find_by(month: last_months_name, year: last_months_year)
   end

   def next_months_schedule
      @next_months_schedule ||= Schedule.find_by(month: next_months_name, year: next_months_year)
   end

private

   # Next month is relative to the month of this schedule.
   def next_months_name
      current_month = (december?) ? 0 : Date::MONTHNAMES.index(month)
      Date::MONTHNAMES[current_month + 1]
   end


   # Next month is relative to the month of this schedule.
   def next_months_year
      (december?) ? (year + 1) : year
   end


   # Last month is relative to the month of this schedule.
   def last_months_name
      current_month = (january?) ? 13 : Date::MONTHNAMES.index(month)
      Date::MONTHNAMES[current_month - 1]
   end


   # Last month is relative to the month of this schedule.
   def last_months_year
      (january?) ? (year - 1) : year
   end

   
   # Is this schedule for January?
   def january?
      month == "January"
   end


   # Is this schedule for December?
   def december?
      month == "December"
   end
end
