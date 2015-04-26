class InvitationsController < ApplicationController

  before_action :authenticate_user!

  def create
    @team = Team.find params[:team_id]
    @new_array = (params[:invitation][:array]).split(",").each do |item|
      item.delete!(" ")
    end
    @new_array.each do |email|
      @invitation = Invitation.new
      # Assign attributes
      @invitation.team = @team
      @invitation.recipient = email
      @invitation.user = current_user
      @invitation.key = SecureRandom.hex

      if User.find_by_email(email)
        @invitation.has_account = true
      else
        @invitation.has_account = false
      end

      if @invitation.save
        # In case the randomly-generated string is not unique, append the Invitation ID 
        @invitation.key = "#{@invitation.key}#{@invitation.id}"
        @invitation.save
        InviteMailer.invite_by_email(@invitation).deliver
      else
        flash[:alert] = "One or more of your email addresses cannot be added to our invitation list"
      end
    end
    redirect_to edit_team_path(@team)
  end

  private
  def invitation_params
    params.require(:invitation).permit(:user_id, :team_id, :key, :recipient, :is_sent, :has_account, :accepted, :array)
  end

end
