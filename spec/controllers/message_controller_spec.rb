require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:message_params) { attributes_for(:message) }

  describe '#index' do
    let(:index_params) { get :index, params: { group_id: group.id } }
    context 'log in' do
      before { login user }

      it 'assigns @message' do
        index_params
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "return a 200 response" do
        index_params
        expect(response).to have_http_status "200"
      end

      it "assings @groups" do
        index_params
        expect(assigns(:group)).to eq @groups
      end

      it 'redners index' do
        index_params
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        index_params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "POST #create" do
    before { login user }
    context "effictive parameter" do
      let(:create_parame) { post :create, params: { group_id: group. id, message: message_params } }

      it "return a 302 response" do
        create_parame
        expect(response).to have_http_status "302"
      end

      it "redirect to group_messages_path when params saved" do
        create_parame
        expect(response).to redirect_to group_messages_path
      end

      it "assigns the created message to @message" do
        expect { create_parame }.to change(Message, :count).by(1)
      end
    end

    context "not effective parameters" do
      let(:uneffective_parameter) { post :create, params: { group_id: group.id, message: { text: '', image: ''}}}

      it "return a 302 response" do
        uneffective_parameter
        expect(response).to have_http_status "302"
      end

      it "redirect to group_messages_path" do
        uneffective_parameter
        expect(response).to redirect_to "/groups/#{group.id}/messages"
      end

      it "not save parameter" do
        expect { uneffective_parameter }.not_to change(Message, :count)
      end
    end
  end

end