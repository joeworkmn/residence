class Apartment < ActiveRecord::Base
   has_one :status, class_name: ApartmentStatus

end
