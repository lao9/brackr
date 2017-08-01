class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user
    unless current_user
      flash[:alert] = "Please login to continue!"
      redirect_to login_path
    end
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
