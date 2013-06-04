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

   default_scope -> { includes(:status) }

   delegate :occupied, :status_start_date, :number_of_tenants, :comment, to: :status, allow_nil: true

   accepts_nested_attributes_for :status

   validates :number, presence: true
   validates :number, numericality: true, allow_blank: true

end
