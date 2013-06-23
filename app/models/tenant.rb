# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fname           :string(255)
#  lname           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  phone_primary   :string(255)
#  phone_secondary :string(255)
#  roles           :text
#  apartment_id    :integer
#  current_role    :string(255)
#  tenant          :boolean          default(FALSE)
#

class Tenant < User
   

   default_scope -> { where(tenant: true) }
   default_scope -> { order(:lname) }

   belongs_to :apartment

   before_create :set_as_tenant


   validates_presence_of :apartment_id

   # Accepts either an Apartment model or just it's id.
   def lives_in?(apartment)
      if apartment.instance_of? Apartment
         self.apartment_id == apartment.id
      else
         self.apartment_id == apartment
      end
   end


   def remove
      if roles.empty?
         self.destroy
      else
         self.tenant = false
         self.save
      end
   end
   

   private

   def set_as_tenant
      self.tenant = true
   end

end
