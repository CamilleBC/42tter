# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @messages = Message.all.order(created_at: :desc)
  end
end
