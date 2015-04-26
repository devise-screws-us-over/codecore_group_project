class InvitationsController < ApplicationController

  before_action :authenticate_user!

  def create
    @team = Team.find params[:team_id]
    @new_array = (params[:invitation][:array]).split(",").each do |item|
      item.delete!(" ")
    end
    # byebug
    # john@john.com      ,       jane@jane.com
    # render text: @new_array
    @new_array.each do |email|
      @invitation = Invitation.new
      # Assign attributes
      @invitation.team = @team
      @invitation.recipient = email
      @invitation.user = current_user
      @invitation.key = SecureRandom.hex
      @invitation.is_sent = false

      if User.find_by_email(email)
        @invitation.has_account = true
      else
        @invitation.has_account = false
      end

      # Save
      @invitation.save
      InviteMailer.email_invitee(@invitation).deliver_later
    end
    redirect_to edit_team_path(@team)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :key, :recipient, :is_sent, :has_account, :accepted, :array)
  end

end
