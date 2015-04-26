class InvitationsController < ApplicationController

  before_action :authenticate_user!

  def create
    @team = Team.find params[:team_id]
    @new_array = (params[:invitation][:array]).split(",")
    # byebug
    # john@john.com      ,       jane@jane.com
    # render text: @new_array
    @new_array.each do |email|
      @invitation = Invitation.new
      # Assign attributes
      @invitation.team = @team
      @invitation.recipient = email.delete(" ")
      @invitation.user = current_user
      @invitation.key = SecureRandom.hex
      @invitation.is_sent = false
      # Save
      @invitation.save
    end
    redirect_to edit_team_path(@team)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :key, :recipient, :is_sent, :has_account, :accepted, :array)
  end

end
