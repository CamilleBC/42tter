# frozen_string_literal: true

class SessionsController < ApplicationController
  def index
    # login form
  end

  def show
    # session home
  end

  def new; end

  def edit; end

  def create
    authorized_user = User.authenticate(session_params[:username_or_email], session_params[:login_password])
    if authorized_user.nil?
      flash.now[:alert] = 'Invalid username or password.'
      flash.now[:color] = 'invalid'
      @username_or_email = session_params[:username_or_email]
      render 'new'
    else
      flash.now[:notice] = "Welcome back, #{authorized_user.username}."
      flash.now[:color] = 'valid'
      login(authorized_user)
      redirect_to authorized_user
    end
  end

  def update
    # session settings
  end

  def destroy
    # logout
  end

  private

  def session_params
    params.require(:session).permit(:username_or_email, :login_password)
  end
end
