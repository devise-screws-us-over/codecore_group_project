class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :invitation_key

  def invitation_key
    if params[:key_match]
      # Store token in cookies
      session[:key_match] = params[:key_match]
    end

  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    redirect_to new_session_path, alert: "Please Sign In!" unless session[:user_id].present?
  end

end
