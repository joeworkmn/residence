class ApartmentStatus < ActiveRecord::Base
   belongs_to :apartment
   validates_date :status_start_date
   #validate :date_has_valid_format





   private

   # Validates to make sure the attribute date has the proper format of m/d/Y
   #def date_has_valid_format
   #   if ((Date.strptime(status_start_date.to_s, "%Y-%m-%d") rescue ArgumentError) == ArgumentError)
   #      errors.add(:status_start_date, "#{status_start_date.nil?.to_s} must have a valid date format")
   #   end
   #end

end
