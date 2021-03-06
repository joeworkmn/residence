module TenantsHelper
   def tenant_form(apt, tenant, options={})

      title = tenant.new_record? ? "New Tenant" : "Edit Tenant"
      btn_label = tenant.new_record? ? "Add Tenant" : "Update Tenant"

      content_tag(:div, :class => 'bg-gray-lighter') do
         raw( # Don't for the raw inside blocks!
            content_tag(:h3, title) +

            simple_form_for([apt, tenant], options) do |f|
               raw( # Don't for the raw inside blocks!
                  f.input(:fname, label: "First Name", required: false) +
                  f.input(:lname, label: "Last Name", required: false)  +
                  f.input(:email)                      +
                  f.input(:phone_primary)              +
                  f.input(:phone_secondary)            +
                  f.submit(btn_label, :class => 'btn btn-primary')   
               )
            end
         )
      end
   end
end
