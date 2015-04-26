class TeamsController < ApplicationController
  # This block is only for testing
  def index
    @team = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to @team
    else
      render 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
    @members = @team.members
    @invitation = Invitation.new
  end

  def show
    if params[:key_match]
      @key_match = params[:key_match]
      flash[:notice] = "You have successfully joined this team!"
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
