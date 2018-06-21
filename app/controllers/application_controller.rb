# frozen_string_literal: true

Dir['./app/policies/*.rb'].each { |file| require file }

class ApplicationController < ActionController::Base
  # to refactor: helpers should only have little view methods
  #    put those in a class method
  include SessionsHelper

  class NotAuthorized < StandardError
  end

  rescue_from NotAuthorized, with: :not_authorized

  def not_authorized
    flash[:danger] = 'This action is not authorized.'
    redirect_back(fallback_location: root_path)
  end

  def authorized?(user, id)
    raise NotAuthorized unless "#{controller_name.humanize.singularize}Policy".constantize.new(user, id).public_send(params[:action] + '?')
  end

  def check_logged_status
    return true if logged_in?
    flash[:danger] = "Please #{view_context.link_to('log in', login_path)} or #{view_context.link_to('sign up', signup_path)} to see that page."
    redirect_back(fallback_location: root_path)
  end
end
