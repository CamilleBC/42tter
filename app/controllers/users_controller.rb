# frozen_string_literal: true

require 'digest/sha1'

class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy deactivate]

  def index
    @users = User.all
  end

  def show
    @messages = @user.messages.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Successful account creation'
      flash[:color] = 'valid'
      redirect_to @user
    else
      flash[:notice] = 'Invalid account'
      flash[:color] = 'invalid'
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.delete_user_messages
    @user.delete
    redirect_to users_path
  end

  def deactivate
    @user.messages.all.each(&:hide) if @user.messages.any?
    @user.active = false
    if @user.save
      flash.notice = 'Successful deactivation'
      redirect_to welcome_index_path
    else
      flash.alert = 'Could not deactivate account'
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
