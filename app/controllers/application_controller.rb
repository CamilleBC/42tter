# frozen_string_literal: true

Dir['./app/policies/*.rb'].each { |file| require file }

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # to refactor: helpers should only have little view methods
  #    put those in a class method
  include SessionsHelper

  class NotAuthorized < StandardError
  end

  rescue_from NotAuthorized, with: :not_authorized

  def not_authorized
    flash[:danger] = 'This action is not authorized.'
    redirect_to root_path
  end

  def authorized?(user, id)
    raise NotAuthorized unless "#{controller_name.humanize.singularize}Policy".constantize.new(user, id).public_send(params[:action] + '?')
  end
end
