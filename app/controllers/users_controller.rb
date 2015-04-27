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

    if current_user
      @user = current_user
       if @user.update(user_params)
        redirect_to profile_path(@user.profile), notice: "Password updated"
      else
        redirect_to profile_path(@user.profile), alert: "Password not updated"
      end
    else 
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to new_session_path, notice: "Password updated"
    end  
  end


  def edit
    @user = User.find(params[:id])
  end

  def delete
    @user = User.find(params[:id])    
  end

  #for the forgot password link
  def forgot_password
    @email = params[:email]
  end

  #for the forgot password link
  def send_password
    @email = params[:email]
    if User.find_by_email(@email)
      @user = User.find_by_email(@email)
      PasswordReminderMailer.notify_password_change(@user).deliver
      #send mailer
      redirect_to new_session_path, notice: "email has been sent with instructions to set password"
    else
      redirect_to forgot_password_path, alert: "sorry, no emails match"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
