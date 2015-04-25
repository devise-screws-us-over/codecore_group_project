class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.find(params[:team_id])

    if @teeam.save
      redirect_to @team
    else
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:team_id])
  end

  def update
    @post = Team.find(params[:id])
    if @team.update(params[:team].permit(:name))
      redirect_to @team
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def team_params
    prams.require(:team).permit(:name)
end
