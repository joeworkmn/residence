module ApplicationHelper

   # For when I want to add messages to a specific portion of the page
   # instead of the top of page.
   def content_message(messages={})
      div = ""
      messages.each do |t, m|
         div += content_tag(:div, m, :class => "alert alert-#{t}")
      end
      raw(div)
   end
end
