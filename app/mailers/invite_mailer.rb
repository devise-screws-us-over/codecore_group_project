class InviteMailer < ApplicationMailer

  def email_invitee(invitation)

    # An ActiveRecord of the invitation
    @invitation = invitation

    # The sender
    @user = @invitation.user

    if @invitation.has_account = true
      @first_name = User.find_by_email(email).first_name
      @last_name = User.find_by_email(email).last_name
    end

    # RECIPIENT'S FULL NAME

    # USER'S FULL NAME
    # TEAM NAME

    # INVITATION KEY

end