class TeamsController < ApplicationController

  before_action :authenticate_user!
  
  # This block is only for testing
  def index
    @team = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.new(team_params)
    #this will assign the user who made the team to the team owner
    @team.owner = current_user
    if @team.save
      #Create a membership to assign this user to that
      #specific team so they don't need an invite
      membership = Membership.create(user_id: @team.owner.id, team_id: @team.id)
      redirect_to @team
    else
      redirect_to root_path
    end
  end

  def edit
    @team = Team.find(params[:id])
    @members = @team.members
    @invitation = Invitation.new
  end

  def show
    # If the key exists in the params hash
    if params[:key_match]
      # Find the Invitation ActiveRecord
      @invitation = Invitation.find_by_key(params[:key_match])
      # Find the User ActiveRecord
      @invitee_email = @invitation.recipient
      # If the invitee HAS USER ACCOUNT
      if User.find_by_email(@invitee_email)
        @invitee_user = User.find_by_email(@invitee_email)
        # Find the Team ActiveRecord
        @team_id = @invitation.team
        @invitation_team = Team.find(@team_id)
        # If the invitee was NOT accepted the invitation
        if @invitation.accepted != true
          flash[:notice] = "You have successfully joined this team!"
          @invitation.accepted = true
          @invitation.save
          # SQL FOR CREATE MEMBERSHIP
          @membership = Membership.create(user_id: @invitee_user.id, team_id: @team_id.id )
          # If the invitee has ALREADY accepted the invitation
        else
          flash[:alert] = "You have already accepted your invitation!"          
        end
      end
    end

    @team = Team.find(params[:id])
    @ideas = @team.most_popular
  end

  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to edit_team_path(@team)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end

end
