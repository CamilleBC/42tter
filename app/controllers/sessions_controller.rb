# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionManager

  def index
    # placeholder
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
    authorized_user = UserAuthenticator.new(session_params[:username_or_email]).authenticate(session_params[:login_password])
    if authorized_user.nil?
      flash.now[:danger] = unauthorized_flash(authorized_user.active?)
      @username_or_email = session_params[:username_or_email]
      render 'new'
    else
      flash[:success] = "Welcome back, #{authorized_user.username}."
      log_in authorized_user
      redirect_to root_url
    end
  end

  def update
    # placeholder
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:username_or_email, :login_password)
  end

  def unauthorized_flash(active)
    return 'Invalid username or password.' if active
    "Account deactivated: please #{view_context.link_to('contact', 'mailto:admin@42tter.io')} an admin"
  end
end
