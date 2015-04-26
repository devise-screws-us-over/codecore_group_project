class SharesController < ApplicationController

  def create
    @idea           = Idea.find params[:idea_id]
    teams           = params["share"]["team_ids"]

    if @idea && teams && teams.count > 1 
        teams.each do |team|
          if !team.blank?
            Share.create(team_id: team, idea_id: @idea.id)
          end
        end
    else
      error = "yourmissing something"
    end
  #  @share.team     = team
  #  @share          = @idea.shares.new
  #  @share.idea     = @idea

    respond_to do |format|
      # if error
        format.html {redirect_to @idea, notice: "Successfully Shared"}
      # end
    end
  end

  def shared_ideas
    #going to iterate over the users teams to be able
    #to get at all of the ideas they have
    @teams = current_user.teams.all
  end


end
