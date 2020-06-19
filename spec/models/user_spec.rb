require 'rails_helper'

describe User do
  describe '#create' do
    # ユーザー名
    ## ユーザーの名前がない場合(エラー)
    it "is invalid without a name" do
      user = build(:user, name: '')
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    ## すべての情報が入力されている場合(サクセス)
    it "is valid with a name and a email, a password, a password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    ## ユーザー名が10文字以上の場合(エラー)
    it "is invalid with a name that has more than 10 characters " do
      user = build(:user, name: 'test-taro-jiro')
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 10 characters)")
    end

    ## ユーザー名が10文字の場合(サクセス)
    it "is valid with a name" do 
      user = build(:user, name: 'test taroo')
      expect(user).to be_valid
    end

    #　メールアドレス
    ##　メールアドレスが未入力の場合(エラー)
    it "is invalid without a email" do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    ## メールアドレスが重複している場合(エラー)
    it "is invalid with a duplicate email address" do
      user = create(:user, email: 'test@gmail.com')
      another_user = build(:user, email: 'test@gmail.com')
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    #　パスワード
    ## パスワードが未入力の場合(エラー)
    it "is invalid without a password" do
      user = build(:user, password: '', password_confirmation: '')
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    ## パスワードと確認用パスワードが異なる場合(エラー)
    it "is invalid　dones't match password nor password_confirmation" do
      user = build(:user, password_confirmation: '12345678')
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    ## パスワードが6文字の場合(サクセス)
    it "is valid with a password(6 characters)" do
      user = build(:user, password: '123456', password_confirmation: '123456')
      expect(user).to be_valid
    end

    ## パスワードが5文字の場合（エラー）
    it "is invalid with a password(5 characters)" do
      user = build(:user, password: '12345', password_confirmation: '12345')
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end