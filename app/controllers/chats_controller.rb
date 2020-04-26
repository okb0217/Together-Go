class ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_back(fallback_location: request.referrer)
    else
      render :show
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    redirect_back(fallback_location: request.referrer)
  end

  def index
    requests_for_me = Request.where(partner_user_id: current_user.id)
    my_requests = Request.where(user_id: current_user.id)
    filtered = []
    requests_for_me.each do |req|
      if my_requests.find_by(partner_user_id:req.user_id)
        filtered.push req.user
      end
    end
    @users = filtered
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :user_id, :room_id)
  end
end
