class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper
  default from: '"Dog Registration Online" <help@dogregistrationonline.example>'
  layout 'mailer'
end
