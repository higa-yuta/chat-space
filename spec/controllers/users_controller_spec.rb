# TODO: make a user_controller test

require 'rails_helper'

# TODO: refactoring

describe UsersController do
  let!(:user) { create(:user) }
  let(:user_params) { { name: 'google', email: 'google@gmail.com' } }

  before do
    login user
  end

  describe "GET #edit" do
    #　画面が表示されるか
    it "renders the :edit template" do
      get :edit, params: { id: user.id }
      
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    # 名前、メールアドレスの変更が保存されるか
    context "changes user's attributes" do
      # let(:user_params) { name: 'google', email: 'google@gmail.com'}
      it "update a user" do
        patch :update, params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq("google")
        expect(user.reload.email).to eq("google@gmail.com")
        end
      #　変更が保存後、root_pathにリダイレクトされるか
      it "redirect the root_path"  do
        patch :update, params: { id: user.id, user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    #  バリデーションがかけられた際に、編集画面にrenderするか
    it "can't update user's attribute" do
      patch :update, params: { id: user.id, user: {
        name: 'googlechrom',
      } }
      expect(response).to render_template :edit
    end
  end
end