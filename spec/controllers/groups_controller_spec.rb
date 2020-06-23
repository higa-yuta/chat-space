require 'rails_helper'

# TODO: add create, update

describe GroupsController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:action) { get :http, params: { id: group }}

  before do
    login user
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: {id: group}
    end

    it "assigns the requested group to @groups" do
      expect(assigns(:group)).to eq group
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end

    it "assigns the requested group to @group" do
      group = create_list(:group, 5)
      expect(assigns(:group)).to match(group.sort{ |a, b| b.created_at <=> a.created_at })
    end
  end
end