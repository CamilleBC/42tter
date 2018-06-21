# frozen_string_literal: true

class SessionsController < ApplicationController
  def index
    # login form
  end

  def show
    # session home
  end

  def new
    # placeholder
  end

  def edit
    # placeholder
  end

  def create
    authorized_user = User.authenticate(session_params[:username_or_email], session_params[:login_password])
    if authorized_user.nil?
      flash.now[:danger] = 'Invalid username or password.'
      @username_or_email = session_params[:username_or_email]
      render 'new'
    else
      flash[:success] = "Welcome back, #{authorized_user.username}."
      log_in(authorized_user)
      redirect_to authorized_user
    end
  end

  def update
    # session settings
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:username_or_email, :login_password)
  end
end
