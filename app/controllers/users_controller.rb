# frozen_string_literal: true

require 'digest/sha1'

class UsersController < ApplicationController
  before_action :check_logged_status, except: %i[create new]
  before_action :find_user, only: %i[show edit update destroy deactivate]
  before_action only: %i[deactivate destroy edit update] do |c|
    c.send(:authorized?, current_user, params[:id])
  end

  def index
    @users = User.all
  end

  def show
    @messages = @user.messages.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def edit
    session[:return_to] = request.referer
end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Successful account creation'
      flash[:success] = "Welcome to 42tter, #{@user.username}"
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid account'
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to session[:return_to]
    else
      render 'edit'
    end
  end

  def destroy
    @user.delete_user_messages
    @user.delete
    redirect_back(fallback_location: users_path)
  end

  def deactivate
    @user.messages.all.each(&:hide) if @user.messages.any?
    @user.active = false
    if @user.save
      log_out unless current_user.role == 'admin'
      flash[:success] = 'Successful deactivation... :sad_panda:'
      redirect_to session[:return_to]
    else
      flash[:danger] = 'Could not deactivate account'
      redirect_to @user
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fullname, :username, :email, :email_confirmation, :password, :password_confirmation)
  end
end
