class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end


  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end


# prefixのtweet_pathを使う際は、:idに何を入れるか指定しなければいけない
# tweet_path(3) => /tweets/3
# tweet_path("hoge") => /tweets/hoge
# tweet_path(@tweet.id) => /tweets/@tweetのid