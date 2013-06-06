class Tenant < User

   belongs_to :apartment
   default_scope -> { where("'tenant' = any(roles)") }

end
