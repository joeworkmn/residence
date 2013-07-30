include SchedulesHelper

def expected_entries_created(sch_form)
   # 2 is the amount of time shifts, day and night.
   sch_form.days_in_month * Shift.count * 2
end


def prepare_new_schedule_form(options = {})
   month = options[:month]       || "May"
   year = options[:year]         || 2013
   intv_len = options[:intv_len] || 7

   create(:schedule_configuration)
   visit new_schedule_path
   submit_schedule_meta_data(month: month, year: year, intv_len: intv_len)
end


def submit_schedule_meta_data(options = {})
   month = options[:month]       || "May"
   year = options[:year]         || 2013
   intv_len = options[:intv_len] || 7

   select(month, from: "Select month:")
   select(year, from: "Select year:")
   fill_in("interval_length", with: intv_len)

   click_button("Submit")
end

def submit_schedule
   click_button "Submit Schedule"
end

def create_shifts(count = 3)
   shifts = []
   count.times { shifts << create(:shift) }
   shifts
end

def create_guards(count = 3)
   guards = []
   count.times { guards << create(:guard) }
   guards
end



# #new view
def interval_row
   ".interval"
end

def day_shift_col
   ".day-shift"
end

def night_shift_col
   ".night-shift"
end


class NewSchedulePage  < ActionDispatch::IntegrationTest

   attr_accessor :month, :year, :intv_len, :guards

   def initialize(options = {})
      @month = options[:month]       || "May"
      @year = options[:year]         || 2013
      @intv_len = options[:intv_len] || 7
   end


   def prepare
      create_shifts
      self.guards = create_guards
      create(:schedule_configuration)
      visit new_schedule_path
      submit_meta_data
      self
   end


   def submit_meta_data
      select(month, from: "Select month:")
      select(year, from: "Select year:")
      fill_in("interval_length", with: intv_len)

      click_button("Submit")
   end


   def fill_in_guards
      day_shift_selects = first(interval_row).find(day_shift_col).all("select")
      night_shift_selects = first(interval_row).find(night_shift_col).all("select")

      day_shift_selects.first.find("option[value='#{guards.first.id.to_s}']").select_option
      day_shift_selects[1].find("option[value='#{guards[1].id.to_s}']").select_option
      day_shift_selects[2].find("option[value='#{guards[2].id.to_s}']").select_option
      
      night_shift_selects.first.find("option[value='#{guards[2].id.to_s}']").select_option
      night_shift_selects[1].find("option[value='#{guards[1].id.to_s}']").select_option
      night_shift_selects[2].find("option[value='#{guards.first.id.to_s}']").select_option

      guards
   end

end
