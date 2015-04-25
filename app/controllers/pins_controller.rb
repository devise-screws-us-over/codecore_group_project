class PinsController < ApplicationController
   before_action :authenticate_user!

   def index
     @pinned_ideas = current_user.pinned_ideas
   end

   def create
     @idea               = Idea.find params[:idea_id]
     @pin                = current_user.pins.new
     @pin.idea           = @idea
      respond_to do |format|
       if @pin.save
         format.html {redirect_to @idea, notifce: "Pinned!"}
       else
         format.html {redirect_to @idea, alert: "Not Pinned"}
       end
     end
   end

   def destroy
     @pin = current_user.pins.find params[:id]
     @idea = @pin.idea
     @pin.destroy

     respond_to do |format|
       format.html {redirect_to @idea, notice: "Unpinned!"}
     end
   end
end
