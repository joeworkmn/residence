module ApplicationHelper

   def full_title(page_title)
      if page_title.blank?
         "Residence"
      else
         "Residence | #{page_title}"
      end
   end

   # For when I want to add messages to a specific portion of the page
   # instead of the top of page.
   def content_message(messages={})
      div = ""
      messages.each do |t, m|
         div += content_tag(:div, m, :class => "alert alert-#{t}")
      end
      raw(div)
   end


   def month_number(month)
      Date::MONTHNAMES.index(month)
   end


   # Determines named route depending on params[:action] and passed in model.
   # Only works for named routes.
   def poly_path(model)
      action = params[:action]
      model_name = model.class.to_s.downcase

      return send("#{model_name}_path", model)      if action == 'show'
      return send("edit_#{model_name}_path", model) if action == 'edit'
      return send("#{model_name.pluralize}_path")   if action == 'index'
   end


   def ransack_search_predicates(*additional_predicates)
      additional_predicates += [:eq, :not_eq, :matches, :lt, :gt, :cont, :true, :false]
   end

   def link_to_add_search_conditions(name, f, type)
      new_object = f.object.send "build_#{type}"
      id = "new_#{type}"
      fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
        render("search_condition_fields", f: builder)
      end
      link_to(name, '#', :class => "add_condition", data: {id: id, fields: fields.gsub("\n", "")})
   end
end
