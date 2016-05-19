class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@thrive-lending.herokuapp.com"
  layout 'mailer'
end
