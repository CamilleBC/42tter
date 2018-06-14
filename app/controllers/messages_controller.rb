# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new; end

  def create
    @message = Message.new(message_params)
    @message.save
    redirect_to @message
  end

  def update
    @message = Message.find(params[:id])
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
