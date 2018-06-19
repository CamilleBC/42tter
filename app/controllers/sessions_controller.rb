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
    # login attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user.nil?
      flash[:alert] = 'Invalid username or password.'
      render 'index'
    else
      flash[:notice] = "Welcome back, #{authorized_user.username}."
      redirect_to @authorized_user
    end
  end

  def update
    # session settings
  end

  def destroy
    # logout
  end
end
