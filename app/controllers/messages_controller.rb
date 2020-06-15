class MessagesController < ApplicationController
  
  before_action :set_group, only: [:index, :create]

  def index
    # @groupsに所属する各ユーザーの名前を配列で返す
    # @users = User.includes(:group).where(id: params[:group_id])
    users = @groups.group_users.map {|group| User.find(group.user_id).name }
    @users = users.join(',')
    @message = Message.new
    @messages = @groups.messages.includes(:user)
  end

  def create
    @message = @groups.messages.new(params_massage)
    redirect_to group_messages_path(params[:group_id]) if @message.save
  end

  private
  def params_massage
    params.require(:message).permit(:text, :image, :group_id).merge(user_id: current_user.id)
  end

  def set_group
    @groups = Group.find(params[:group_id])
  end

end