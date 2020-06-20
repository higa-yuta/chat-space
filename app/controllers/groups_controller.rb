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
    comfirm_name = Group.all.map(&:name).include?(group_params[:name])
    unless comfirm_name
      @group = Group.new(group_params)
      redirect_to root_path, notice: 'succsess' if @group.save
    else
      flash.now[:alert] = 'そのグループはすでに存在します'
      redirect_to new_group_path
    end
  end

  def edit;end

  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'succsess'
    else
      redirect_to :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { :user_ids => []})
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
