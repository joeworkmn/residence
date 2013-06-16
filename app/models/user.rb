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

class User < ActiveRecord::Base

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

   validates :fname, presence: true
   validates :lname, presence: true
   validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true


   def name
      "#{fname} #{lname}"
   end


   def name_reversed
      "#{lname}, #{fname}"
   end


   def roles
      read_attribute(:roles) || write_attribute(:roles, [])
   end

end
