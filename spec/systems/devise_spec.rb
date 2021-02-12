require 'rails_helper'

RSpec.describe 'Dvise', type: :system do
  let(:user) { create(:user) }

  it 'ログイン成功・ログアウト' do
    visit new_user_session_path
    fill_in 'user[email]',	with: user.email
    fill_in 'user[password]',	with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    find(".dropdown-toggle").click
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end

  it 'ログイン失敗' do
    visit '/users/sign_in'
    fill_in 'user[email]',	with: user.email
    fill_in 'user[password]',	with: 'abcdef'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

end