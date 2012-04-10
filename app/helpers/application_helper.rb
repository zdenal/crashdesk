module ApplicationHelper

  def flash_messages
    messages = ""
    flash.keys.each do |key|
      css_class = case key
        when :notice then :success
        when :alert then :error
        else key
      end
      messages << content_tag(:div, :class => "alert alert-#{css_class}") do
        link_to( "x", "javascript:void(0);", class: 'close',
          data: {dismiss: 'alert'} ) + flash[key]
      end
    end
    messages.html_safe
  end

end
