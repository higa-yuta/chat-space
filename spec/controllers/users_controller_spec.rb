# TODO: make a user_controller test

require 'rails_helper'

# TODO: refactoring

describe UsersController do
  let(:user) { create(:user) }
  before { login user }

  describe "GET #edit" do
    before { get :edit, params: { id: user } }
    #　画面が表示されるか
    it "renders the :edit template" do
      expect(response).to render_template :edit
    end

    it "return a 200 response" do
      expect(response).to have_http_status "200"
    end
  end

  describe "PATCH #update" do
    context "changes user's attributes" do
      let(:user_params) { patch :update, params: { id: user.id, user: { name: 'google' } }
      expect(response).to have_http_status "302" }

      it "return a 302 response" do
        user_params
        expect(response).to have_http_status "302"
      end

      it "update a user" do
        user_params
        expect(user.reload.name).to eq("google")
        end
      #　変更が保存後、root_pathにリダイレクトされるか
      it "redirect the root_path"  do
        user_params
        expect(response).to redirect_to root_path
      end
    end

    context "when not effective paramters" do
      let(:not_effective_params) { patch :update, params: { id: user.id , user: { name: nil } } }
      it "redirect_to :edit template" do
        not_effective_params
        expect(response).to redirect_to "/users/#{user.id}/edit"
      end

      it "return a 302 response" do
        not_effective_params
        expect(response).to have_http_status "302"
      end
    end
    
  end
end