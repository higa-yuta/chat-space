class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update]

  def index
    @group = Group.all
  end

  def new
    @group = Group.new
    @group.users << @group.users &&= @group.users
  end

  def create
    unless include_newname?(group_params)
      @group = Group.new(group_params)
      if @group.save
        redirect_to root_path, notice: 'succsess'
      else
        redirect_to new_group_path
      end
    else
      flash.now[:alert] = 'そのグループはすでに存在します'
      redirect_to new_group_path
    end
    # @group = Group.new(group_params)
    # if @group.valid?
    #   redirect_to root_path, notice: 'succsess' if @group.save
    # else
    #   redirect_to new_group_path
    # end
  end

  def edit;end

  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'succsess'
    else
      redirect_to controller: :groups, action: :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { :user_ids => []})
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def include_newname?(params)
    current_user.groups.all.map(&:name).include?(group_params[:name])
  end

end