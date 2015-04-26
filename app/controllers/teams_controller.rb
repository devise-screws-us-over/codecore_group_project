class TeamsController < ApplicationController
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
    redirect_to root_path, alert: "access denied" unless can? :manage, @team
    @invitation = Invitation.new
  end

  def show
    @team = Team.find(params[:id])
    @ideas = @team.most_popular
  end

  def update
    @team = Team.find(params[:id])
    redirect_to root_path, alert: "access denied" unless can? :manage, @team
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
