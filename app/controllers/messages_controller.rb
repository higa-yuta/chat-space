class MessagesController < ApplicationController
  
  before_action :set_group, only: :index

  def index
    @message = Message.new
    @messages = @groups.messages.includes(:user).order(created_at: :desc)
    group_member(@groups)
  end

  def create
    @message = Message.new(params_massage)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(params[:group_id]) }
        format.json
      end
    else
      redirect_to group_messages_path(params[:group_id])
    end
  end

  private
  def params_massage
    params.require(:message)
          .permit(:text, :image)
          .merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_group
    exist_group = Group.all.map(&:id).include?(params[:group_id].to_i)
    if exist_group
      @groups = Group.find(params[:group_id])
    else
      redirect_to root_path, notice: 'そのグループはありません'
    end
  end

  def group_member(group)
    # @groupsに所属する各ユーザーの名前を配列で返す
    # @users = User.includes(:group).where(id: params[:group_id])
    users = @groups.users.map(&:name)
    @users = users.join(',')
  end

end