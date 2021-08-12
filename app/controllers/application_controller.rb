class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user_logged_in!
    # allows only logged in user
    redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
  end

  def valid_account?
    user = User.find_by(user_name: params[:user_name])
    if user.present?
       redirect_to root_path, notice: 'User account is locked.' if user.login_attempt >= 3
    end
  end
end
