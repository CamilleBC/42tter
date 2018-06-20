# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    false if current_user.nil?
    true
  end
end
