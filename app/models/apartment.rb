# == Schema Information
#
# Table name: apartments
#
#  id     :integer          not null, primary key
#  number :integer
#

class Apartment < ActiveRecord::Base
   has_one :status, class_name: ApartmentStatus, dependent: :destroy

   default_scope -> { includes(:status) }

   delegate :occupied, to: :status, allow_nil: true
   delegate :status_start_date, to: :status, allow_nil: true
   delegate :number_of_tenants, to: :status, allow_nil: true
   delegate :comment, to: :status, allow_nil: true

   accepts_nested_attributes_for :status

   validates :number, numericality: true, allow_blank: true

end
