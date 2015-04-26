class UsersController < ApplicationController

  layout "external"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      # If there is a pending invitation with the new user's email address
      if Invitation.find_by_recipient(@user.email)
        invitation = Invitation.find_by_recipient(@user.email)
        membership = Membership.create(user_id: @user.id, team_id: invitation.team.id)
      end

      redirect_to new_profile_path, notice: "Account Created. Please Create Your Profile!"
    else
      render :new
      flash[:alert] = "Can't Create Account!"
    end
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
