# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :find_message, only: %i[show edit update destroy hide]

  def index
    @messages = Message.all
    @user = User.find(params[:user_id])
  end

  def show; end

  def new
    @message = Message.new
  end

  def edit; end

  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.create(message_params)
    redirect_to user_path(@user)
  end

  def update
    @user = User.find(params[:user_id])
    if @message.update(message_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @message.destroy
    redirect_to @user
  end

  def hide
    @message.hide
    redirect_to @message.user
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
