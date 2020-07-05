require 'rails_helper'

# TODO: create group test

feature 'group', type: :feature do
  let(:user) { create(:user) }
  let(:group) { build(:group) }

  scenario 'post group' do
    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name=commit]').click
    expect(current_path).to eq root_path
    expect(page).to have_content(user.name)

    #　グループ作成
    expect {
      click_link 'new-group'      
      expect(current_path).to eq new_group_path
      fill_in 'group_name', with: group.name
      find('input[type=submit]').click
    }.to change(Group, :count).by(1)
  end
end