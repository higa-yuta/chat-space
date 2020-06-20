require 'rails_helper'


describe GroupsController do
  # new 
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  #edit
  describe 'GET #edit' do
    it "assigns the requested group to @groups" do
      group = create(:group)
      get :edit, params: { id: group }
      expect(assigns(:group)).to eq group
    end

    it "renders the :edit template" do
      group = create(:group)
      get :edit, params: { id: group }
      expect(response).to render_template :edit
    end
  end

  #index
  describe 'GET #index' do
    it "renders the :index template" do
      group = create(:group)
      get :index
      expect(response).to render_template :index
    end

    it "assigns the requested group to @group" do
      group = create_list(:group, 5)
      get :index
      expect(assigns(:group)).to match(group.sort{ |a, b| b.created_at <=> a.created_at })
    end
  end
end