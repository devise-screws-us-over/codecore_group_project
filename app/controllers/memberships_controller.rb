class MembershipsController < ApplicationController
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    
    if params[:admin_delete]
      flash[:notice] = "You have removed the member from the team"
      redirect_to edit_team_path(params[:team_id])
    else
      redirect_to ideas_path, notice: "You have left the team"
    end

  end


end
