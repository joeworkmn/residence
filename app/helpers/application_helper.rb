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


   def ransack_search_predicates(*additional_predicates)
      additional_predicates += [:eq, :not_eq, :matches, :lt, :gt, :cont, :true, :false]
   end
end
