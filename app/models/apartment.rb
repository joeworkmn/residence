# == Schema Information
#
# Table name: apartments
#
#  id              :integer          not null, primary key
#  number          :integer
#  username        :string(255)
#  password_digest :string(255)
#

class Apartment < ActiveRecord::Base

   has_secure_password

   has_one :status, class_name: ApartmentStatus, dependent: :destroy
   has_many :tenants, class_name: Tenant, dependent: :destroy

   default_scope -> { includes(:status) }
   default_scope -> { order("number ASC") }

   delegate :occupied, :status_start_date, :number_of_tenants, :comment, to: :status, allow_nil: true

   accepts_nested_attributes_for :status

   validates :number, presence: true, uniqueness: { case_sensitive: false }



   # Define this method to prevent "no method" 
   # errors when doing authorization.
   def is(role)
      role = role.to_s
      role == 'tenant'
   end
end
