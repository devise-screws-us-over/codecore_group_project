class PinsController < ApplicationController
   before_action :authenticate_user!

   def index
     @pins = current_user.pins
   end

   def create
     @idea               = Idea.find params[:idea_id]
     @pin                = current_user.pins.new
     @pin.idea           = @idea
      respond_to do |format|
       if @pin.save
         format.html {redirect_to @idea, notifce: "Pinned!"}
         format.js { render }
       else
         format.html {redirect_to @idea, alert: "Not Pinned"}
         format.js { render }
       end
     end
   end

   def destroy
     @pin = current_user.pins.find params[:id]
     @idea = @pin.idea
     @pin.destroy

     respond_to do |format|
       format.html {redirect_to @idea, notice: "Unpinned!"}
       format.js { render }
     end
   end
end
