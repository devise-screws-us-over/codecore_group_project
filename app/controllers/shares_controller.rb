class ProfilesController < ApplicationController

 def create
   @idea           =Idea.find params[:idea_id]
   @share          =@idea.shares.new
   @share.idea     =@idea
   respond_to do |format|
     if @share.save
       format.html {redirect_to @idea, notice: "Successfully Shared"}
     else
       format.html {redirect_to @idea, alert: "Not Shared"}
     end
   end
 end
end
