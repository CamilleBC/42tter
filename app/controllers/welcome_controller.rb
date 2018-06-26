# frozen_string_literal: true

class WelcomeController < ApplicationController
  include SessionManager

  def index
    if logged_in?
      @message = Message.new
      @message.user_id = current_user.id
    end
    @messages = Message.all.order(created_at: :desc).includes(:user)
  end
end
