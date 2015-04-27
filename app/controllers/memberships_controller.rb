class MembershipsController < ApplicationController
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to ideas_path, notice: "You have left the team"
  end
end
