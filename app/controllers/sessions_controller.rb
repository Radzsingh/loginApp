# frozen_string_literal: true

# Handles sessions create and destroy
class SessionsController < ApplicationController
  before_action :filter_access
  before_action :find_user, only: [:create]

  def new; end

  def create
    if @user.present? && @user.authenticate(params[:password])
      # sets up user.id sessions
      session[:user_id] = @user.id
      @user.reset_attempt
      redirect_to root_path, notice: 'Logged in successfully'
    else
      @user.record_attempt if @user.present?
      flash[:alert] = 'Invalid email or password'
      flash[:alert] = 'User account is locked!' if account_locked?
      redirect_to sign_in_path, status: :unauthorized
    end
  end

  def find_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def destroy
    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end
end
