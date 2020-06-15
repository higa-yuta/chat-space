class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update]

  def index
    @group = Group.all
  end

  def new
    @group = Group.new
    @group.users << @group.users &&= @group.users
    console
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'succsess'
    else
      render :new
    end
  end

  def edit;end

  def update
    if @group.update(group_params)
      redirect_to root_path, notice: 'succsess'
    else
      render :new
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
