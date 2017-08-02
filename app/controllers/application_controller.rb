class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def authenticate_user
    unless current_user
      redirect_to login_path, :alert => 'Please log in to continue!'
    end
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
