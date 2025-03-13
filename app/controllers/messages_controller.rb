class MessagesController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(params.require(:message).permit(:message, :room_id).merge(user_id: current_user.id))
      
      if @message.save
        redirect_to "/rooms/#{@message.room_id}"
      else
        flash[:alert] = "メッセージ送信に失敗しました"
        redirect_to "/rooms/#{params[:message][:room_id]}"
      end
    else
      flash[:alert] = "メッセージ送信に失敗しました"
      redirect_to "/rooms/#{params[:message][:room_id]}"
    end
  end
end
