module ApplicationHelper

  def render_next_event(event)
    unless event.nil?
      content_tag(:div, "Next event: #{event.title}") +
      content_tag(:div, "#{event.preview}")
    end
  end

end
