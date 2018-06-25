# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :check_logged_status
  before_action :find_message, only: %i[show edit update destroy hide]

  def index
    @messages = Message.all
    @user = User.find(params[:user_id])
  end

  def show; end

  def new
    @message = Message.new
  end

  def edit
    session[:return_to] = request.referer
 end

  def create
    @user = User.find(params[:user_id])
    @message = @user.messages.create(message_params)
    redirect_to session[:return_to]
  end

  def update
    @user = User.find(params[:user_id])
    if @message.update(message_params)
      redirect_to session[:return_to]
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @message.destroy
    redirect_to root_path
  end

  def hide
    @message.hide
    redirect_back(fallback_location: root_path)
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :parent, :parent_id)
  end
end
