require 'rails_helper'

RSpec.describe "Users", type: :system do
  
  describe 'ユーザー検索機能' do
    let!(:user1) { create :user1 }
    let!(:user2) { create :user2 }
    before do
      visit users_path
    end
    it 'ユーザー名検索' do
      fill_in 'q[username_cont]', with: '1'
      click_on '検索'
      expect(page).to have_content 'user1'
      expect(page).not_to have_content 'user2'
    end
    it '好きなゲーム検索' do
      fill_in 'q[favorite_cont]', with: 'ドラゴン'
      click_on '検索'
      expect(page).to have_content 'user1'
      expect(page).not_to have_content 'user2'
    end
    it '性別検索' do
      find('#q_sex_eq').find("option[value='1']").select_option
      click_on '検索'
      expect(page).to have_content 'user1'
      expect(page).not_to have_content 'user2'
    end
    it '年齢検索' do
      find('#q_ages_eq').find("option[value='1']").select_option
      click_on '検索'
      expect(page).to have_content 'user1'
      expect(page).not_to have_content 'user2'
    end
    it '並び替え' do
      find('#q_sorts').find("option[value='username asc']").select_option
      expect(page.body.index('user1')).to be < page.body.index('user2')
    end
  end

  describe 'マイゲーム切り替え' do
    let!(:user1) { create :user1 }
    let!(:game1) { create :game1, user: user1 } 
    let!(:game2) { create :game2, user: user1, status: 1, clear_day: Time.current.tomorrow }
    before do
      visit new_user_session_path
      fill_in 'user[email]',	with: user1.email
      fill_in 'user[password]',	with: user1.password
      click_button 'ログイン'
      visit mygames_user_path(user1.id, name: 'all')
    end
    it '「全て」から「未クリア」' do
      click_link '未クリア'
      expect(page).to have_content game1.title
      expect(page).not_to have_content game2.title
    end
    it '「全て」から「クリア済み」' do
      click_link 'クリア済み'
      expect(page).to have_content game2.title
      expect(page).not_to have_content game1.title
    end
  end
  
end
