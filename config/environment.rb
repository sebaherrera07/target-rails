# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Removes de wrapper field_with_errors that adds by default after validation
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  html_tag.html_safe
end
