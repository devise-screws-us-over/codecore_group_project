class InvitationsController < ApplicationController

  def create
    @team = Team.find params[:team_id]
    @new_array = (params[:invitation][:array]).split(",")
    # render text: @new_array
    @new_array.each do |email|
      @invitation = Invitation.new
      @invitation.team = @team
      @invitation.recipient = email
      @invitation.save
    end
    redirect_to edit_team_path(@team)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :key, :recipient, :is_sent, :has_account, :accepted, :array)
  end

end
