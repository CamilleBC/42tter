# frozen_string_literal: true

class SessionsController < ApplicationController
  def index
    # session home
  end

  def show
    # placeholder
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
    elsif !authorized_user.active?
      flash.now[:danger] = "Account deactivated: please #{view_context.link_to('contact', 'mailto:admin@42tter.io')} an admin"
      @username_or_email = session_params[:username_or_email]
      render 'new'
    else
      flash[:success] = "Welcome back, #{authorized_user.username}."
      log_in(authorized_user)
      redirect_to root_url
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
