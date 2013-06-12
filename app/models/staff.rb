class Staff < User
   default_scope -> { staff_only } 

   has_secure_password

   before_validation :check_roles

   validates :username, presence: true, uniqueness: { case_sensitive: false }
   validates :roles, presence: { message: "Must select at least one" }


   def remove
      if tenant?
         self.roles = []
         self.save(validate: false)
      else
         self.destroy
      end
   end
   
   
private

   def self.staff_only
      sql = ""
      ROLES.each do |s|
         sql += "'#{s}' = ANY(roles)"
         sql += " OR " unless s.equal? ROLES.last # equal? tests for object equality
      end
      where(sql)
   end
   
   def check_roles
      # If no role was chosen, roles becomes [""] which will pass validation. So set it to []
      self.roles = [] if roles.size == 1 && roles.first.blank?
   end
end

