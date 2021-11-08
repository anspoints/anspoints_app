# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    # via https://coderwall.com/p/jzofog/ruby-on-rails-flash-messages-with-bootstrap
    # Pair with this in a view:
    # <% flash.each do |key, value| %>
    #       <div class="<%= flash_class(key) %>" role="alert">
    #             <%= value %>
    #       </div>
    # <% end %>
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    else ''
    end
  end
end
