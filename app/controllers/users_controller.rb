class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    error_messages = @user.check_user_errors(check_user_params)
    if error_messages.empty?
      @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome!"
      redirect_to bracks_path
    else
      flash[:error] = error_messages
      redirect_to new_user_path
    end
  end

  private

  def check_user_params
    user_params.merge!({pass_confirm: params[:user][:password_confirmation]})
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :organization)
  end

end
