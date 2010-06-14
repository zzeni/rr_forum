# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

#   Here the line helper :all includes the helpers in all the views,
#   but not in the controllers. We need the methods from the Sessions
#   helper in both places, so we have to include it explicitly.
  include SessionsHelper

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

end
