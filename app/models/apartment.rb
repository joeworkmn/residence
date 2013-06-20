# == Schema Information
#
# Table name: apartments
#
#  id              :integer          not null, primary key
#  number          :integer
#  password_digest :string(255)
#

class Apartment < ActiveRecord::Base

   has_secure_password

   has_one :status, class_name: ApartmentStatus, dependent: :destroy
   has_many :tenants, class_name: Tenant, dependent: :destroy
   has_many :tickets, dependent: :destroy

   default_scope -> { includes(:status) }
   default_scope -> { order("number") }

   delegate :occupied, :occupied=, :occupied?, :status_start_date, :number_of_tenants, :comment, to: :status, allow_nil: true

   accepts_nested_attributes_for :status

   validates :number, presence: true, numericality: true, uniqueness: { case_sensitive: false }

   after_update :vacate, unless: -> { occupied }



   def state
      occupied ? "Occupied" : "Vacant"
   end

   # Define this method to prevent "no method" 
   # errors when doing authorization.
   def is?(role)
      role.to_s == 'tenant'
   end


   def self.ransackable_attributes(auth_object = nil)
      %w( number ) + _ransackers.keys
   end

   private

   def vacate
      tickets.destroy_all
      tenants.destroy_all
   end

end
