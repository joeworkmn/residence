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
#  apartments_id   :integer
#

class User < ActiveRecord::Base

   ROLES = %w[manager guard tenant]
   STAFF = %w[manager guard] # explicitly set STAFF to be safe.

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

   # Still hashes password.
   has_secure_password validations: false

   before_validation :check_roles, unless: -> { is_tenant? }
   #before_validation :check_password_confirmation, unless: -> { is_tenant? }

   validates :username, presence: true, uniqueness: { case_sensitive: false }, unless: -> { is_tenant? }
   validates :password, presence: true, unless: -> { is_tenant? }
   validates_confirmation_of :password
      
   validates :roles, presence: { message: "Must select at least one" }, unless: -> { is_tenant? }
   validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true


   def self.staff
      sql = ""
      STAFF.each do |s|
         sql += "'#{s}' = ANY(roles)"
         sql += " OR " unless s.equal? STAFF.last # equal? tests for object equality
      end
      where(sql)
   end


   def name
      "#{fname} #{lname}"
   end


   def name_reversed
      "#{lname}, #{fname}"
   end


   def has_role?(role)
      role = role.to_s
      roles.include? role
   end


   def is?(role)
      role = role.to_s
      current_role == role
   end

   def is_tenant?
      self.instance_of? Tenant
   end


   private


   def check_roles
      # If no role was chosen, roles becomes [""] which will pass validation. So set it to []
      self.roles = [] if roles.size == 1 && roles.first.blank?
   end

end
