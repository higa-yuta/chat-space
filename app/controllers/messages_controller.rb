class MessagesController < ApplicationController
  
  before_action :set_group, only: [:index, :create]

  def index
    @message = Message.new
    @messages = @groups.messages.includes(:user).order("created_at desc")
    group_member(@groups)
  end

  def create
    @message = @groups.messages.new(params_massage)
    if @message.save
      redirect_to group_messages_path(params[:group_id])
    # else
    #   redirect_to group_messages_path(params[:group_id])
    end
  end

  def group_member(group)
    # @groupsに所属する各ユーザーの名前を配列で返す
    # @users = User.includes(:group).where(id: params[:group_id])
    users = @groups.group_users.map {|group| User.find(group.user_id).name }
    @users = users.join(',')
  end

  private
  def params_massage
    params.require(:message).permit(:text, :image, :group_id).merge(user_id: current_user.id)
  end

  def set_group
    group = Array(Group.all).map(&:id).include?(params[:group_id].to_i)
    if group
      @groups = Group.find(params[:group_id])
    else
      redirect_to root_path, notice: 'そのグループはありません'
    end
  end

end