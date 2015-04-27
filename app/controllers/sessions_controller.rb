class SessionsController < ApplicationController

  layout "external"

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      #on sign-in, we will look in the cookies for the key_match token
      # Find the Invitation ActiveRecord
      if session[:key_match]
        @invitation = Invitation.find_by_key(session[:key_match])
        # Find the User ActiveRecord
        @invitee_email = @invitation.recipient
        # If the invitee HAS USER ACCOUNT
        if User.find_by_email(@invitee_email)
          @invitee_user = User.find_by_email(@invitee_email)
          # Find the Team ActiveRecord
          @team_id = @invitation.team
          @invitation_team = Team.find(@team_id)
          #If the invitee was NOT accepted the invitation
          if @invitation.accepted != true
            flash[:notice] = "You have successfully joined this team!"
            @invitation.accepted = true
            @invitation.save
            # SQL FOR CREATE MEMBERSHIP
            @membership = Membership.create(user_id: @invitee_user.id, team_id: @team_id.id )
            # If the invitee has ALREADY accepted the invitation
            session[:key_match] = nil
          else
            flash[:alert] = "You have already accepted your invitation!"          
          end
        end

      end

      redirect_to root_path
    else
      render :new
      flash[:alert] = "Invalid Login"
    end    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out"
  end
end
