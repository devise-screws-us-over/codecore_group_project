class UsersController < ApplicationController

  layout "external"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #create an empty profile for the user when they first sign up
      @user.profile = Profile.create
      session[:user_id] = @user.id

      # # If there is a pending invitation with the new user's email address
      if Invitation.find_by_key(session[:key_match])
        invitation = Invitation.find_by_key(session[:key_match])
        membership = Membership.create(user_id: @user.id, team_id: invitation.team.id)
        invitation.accepted = true
        invitation.save
        session[:key_match] = nil
      end

      redirect_to root_path, notice: "Account Created. Welcome to Ideaz!!"
    else
      render :new
      flash[:alert] = "Can't Create Account!"
    end
  end


  def update
    # @user = current_user
    # @user.update(user_params)
    # redirect_to profile_path
  end


  def edit
    @user = User.find(params[:id])
  end

  def delete
    @user = User.find(params[:id])    
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
