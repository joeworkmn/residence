class Tenant < User
   default_scope -> { where("'manager' = any(roles)") }

end
