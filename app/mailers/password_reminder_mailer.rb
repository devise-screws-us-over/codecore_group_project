class PasswordReminderMailer < ApplicationMailer

  def notify_password_change(user)
    @user = user
    mail(to: @user.email, subject: "Instructions to reset your password")
  end

end
