require 'rails_helper'

describe GroupsController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:action) { get :http, params: { id: group }}
  let(:group_params) { attributes_for(:group) }
  # let(:invalid_group) { attributes_for(:invalid_group) }

  before { login user }

  describe 'GET #index' do
    before { get :index }
    it "return a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end

    it "assigns the requested group to @group" do
      group = create_list(:group, 5)
      expect(assigns(:group)).to match(group.sort{ |a, b| b.created_at <=> a.created_at })
    end
  end


  describe 'GET #new' do
    before { get :new }
    it "renders the :new template" do
      expect(response).to render_template :new
    end

    it "return a 200 response" do
      expect(response).to have_http_status "200"
    end

    it "assigns the requested group to @group" do
      expect(assigns(:group)).to be_a_new(Group)
    end
  end


  describe "POST #create" do
    context "when an effective parameter" do
      before { post :create, params: { group: group_params } }
      it "rediect to root_path when params saved" do
        expect(response).to redirect_to root_path
      end

      it "assigns the created group to group" do
        expect { post :create, params: { group: group_params }}.to change(Group, :count).by(1)
      end

      it "return a 302 response" do
        expect(response).to have_http_status "302"
      end
    end

    context "when no effective parameter" do
      before { post :create, params: { group: { name: nil } } }
      it "return a 302 response" do
        expect(response).to have_http_status "302"
      end

      it "not save parameter" do 
        expect { post :create, params: { group: { name: '' } } }.not_to change(Group, :count)
      end

      it "redirect to :new template when can not create new group" do
        expect(response).to redirect_to "/groups/new"        
      end
    end
  end 


  describe 'GET #edit' do
    before { get :edit, params: {id: group} }

    it "assigns the requested group to @groups" do
      expect(assigns(:group)).to eq group
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end

    it "return a 200 response" do
      expect(response).to have_http_status "200"
    end
  end


  describe "PATCH #update" do
    context "when an effective parameter" do
      let(:group_params) { {name: 'google'} }
      let(:effective_parames) { patch :update, params: { id: group.id, group: group_params } }
      it "update a gruop's attributes" do
        effective_parames
        expect(group.reload.name).to eq "google"
      end

      it "return a 302 response" do
        effective_parames
        expect(response).to have_http_status "302"
      end

      it "redirect to the root_path" do
        effective_parames
        expect(response).to redirect_to root_path
      end
    end
    
    context 'when no effective parameters' do
      let(:not_effective) { {name: nil} }
      before { patch :update, params: { id: group.id, group: not_effective } }

      it "redirect to :edit template" do
        expect(response).to redirect_to "/groups/#{group.id}/edit"
      end

      it "return a 302 response" do
        expect(response).to have_http_status "302"
      end
    end
    
  end
end