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
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @post = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to @team
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
