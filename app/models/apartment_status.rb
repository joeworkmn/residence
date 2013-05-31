class ApartmentStatus < ActiveRecord::Base
   belongs_to :apartment
   validates_date :status_start_date

   # Not working.
   before_save :default_status_start_date, if: -> { !status_start_date.valid? }
                                                
   private

   def default_status_start_date
      self.status_start_date = Time.now
   end


end
