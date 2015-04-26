class ApplicationMailer < ActionMailer::Base
  default from: "The Ideaz Team <invit@ideaz.com>"
  # Commenting this out because we are not using a layout
  layout 'mailer'
end
