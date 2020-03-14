module FlashHelper
  def flash_notify
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      type = :danger if type.to_sym == :timedout
      Array(message).each do |msg|
        text = content_tag(:div, msg.html_safe, :class => "alert alert-#{type} rounded-0 mb-0")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
