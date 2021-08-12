# Controls the flow of application before serving requests
class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def account_locked?
    # check for locked account
    user = User.find_by(user_name: params[:user_name])
    user && user.login_attempts > 2 ? true : false
  end

  def filter_access
    # redirect if account is locked
    if account_locked?
      flash[:notice]= 'User account is locked.'
      redirect_to root_path and return
    end
  end
end
