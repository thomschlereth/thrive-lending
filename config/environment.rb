# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

    ActionMailer::Base.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 587,
      domain:               'thrive-lending.herokuapp.com',
      user_name:            ENV["SENDGRID_USER_NAME"],
      password:             ENV["SENDGRID_PASSWORD"],
      authentication:       :plain,
      enable_starttls_auto: true
    }