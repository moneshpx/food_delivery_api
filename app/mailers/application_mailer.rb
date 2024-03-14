class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:user_name)
  layout "mailer"
end
