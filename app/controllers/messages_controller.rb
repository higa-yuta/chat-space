class MessagesController < ApplicationController

  def index
    @group = Group.all
    @groups = Group.find(params[:group_id])
    # @groupsに所属する各ユーザーの名前を配列で返す
    users = @groups.group_users.map {|group| User.find(group.user_id).name }
    @users = users.join(',')
  end

  
end
    