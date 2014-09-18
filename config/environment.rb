# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
RailsBootstrap::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => "smtp.westmont.edu",
  :port => 25
}
