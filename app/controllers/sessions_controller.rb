class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome!"
      redirect_to bracks_path
    else
      flash[:error] = "Invalid Username or Password!"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "Goodbye!"
    redirect_to login_path
  end

end
