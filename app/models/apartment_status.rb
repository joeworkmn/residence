# == Schema Information
#
# Table name: apartment_statuses
#
#  id                :integer          not null, primary key
#  occupied          :boolean
#  status_start_date :date
#  number_of_tenants :integer
#  apartment_id      :integer
#  comment           :text
#

class ApartmentStatus < ActiveRecord::Base
   belongs_to :apartment

   validates_date :status_start_date, allow_blank: true



   private

end
