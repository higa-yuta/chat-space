require 'rails_helper'

describe Message do
  describe "#create" do
    context 'can save' do
        # テキストも写真も入っている(サクセス)
      it "is valid with a text and image" do
        message = build(:message)
        expect(message).to be_valid
      end

      # テキストはないが写真はある場合(サクセス)
      it "is valid without a text but has been entered a image" do
        message = build(:message, text: '')
        expect(message).to be_valid
      end

      #　写真はないがテキストは入力されている(サクセス)
      it "is valid without a image but has benn entered a text" do
        message = build(:message, image: '')
        expect(message).to be_valid
      end
    end
    
    context 'can not save' do
      # テキストと写真が入力されてない場合(エラー)
      it "is invalid without a text and image" do
        message = build(:message, text: '', image: '')
        message.valid?
        expect(message.errors[:image]).to include("can't be blank")
      end

      #　group_idがない場合(エラー)
      it "is invalid without a group_id" do
        message = build(:message, group_id: '')
        message.valid?
        expect(message.errors[:group_id]).to include("can't be blank")
      end

        #　user_idがない場合(エラー)
      it "is invalid without a user_id" do
        message = build(:message, user_id: '')
        message.valid?
        expect(message.errors[:user_id]).to include("can't be blank")
      end
    end
  end
end