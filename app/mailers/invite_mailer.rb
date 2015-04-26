class InviteMailer < ApplicationMailer

  # layout 'mailer'

  def invite_by_email(invitation)

    # An ActiveRecord of the invitation
    @invitation = invitation

    # The sender
    @user = @invitation.user

    if @invitation.has_account == true
      @first_name = User.find_by_email(@invitation.recipient).first_name
      @last_name = User.find_by_email(@invitation.recipient).last_name
    end

    mail(to: @invitation.recipient, subject: "You are invited to join Team #{@invitation.team.name}")
     # do |format| format.html.erb { render layout: 'mailer'} end
  end

end