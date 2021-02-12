require 'rails_helper'

RSpec.describe "Games", type: :system do

  describe 'ゲーム検索機能' do
    let!(:user1) { create :user1 }
    let!(:game1) { create :game1, user: user1 } 
    let!(:game2) { create :game2, user: user1 }
    before do
      visit games_path
    end
    it 'タイトル検索' do
      fill_in 'q[title_cont]', with: 'ウイニング'
      click_on '検索'
      expect(page).to have_content 'ウイニングポスト9'
      expect(page).not_to have_content 'ダービースタリオン'
    end
    it 'ジャンル検索' do
      find('#q_genre_eq').find("option[value='1']").select_option
      click_on '検索'
      expect(page).to have_content 'ウイニングポスト9'
      expect(page).not_to have_content 'ダービースタリオン'
    end
    it 'プラットフォーム検索' do
      find('#q_machine_eq').find("option[value='0']").select_option
      click_on '検索'
      expect(page).to have_content 'ウイニングポスト9'
      expect(page).not_to have_content 'ダービースタリオン9'
    end
    it '並び替え' do
      find('#q_sorts').find("option[value='title asc']").select_option
      expect(page.body.index('ウイニングポスト9')).to be < page.body.index('ダービースタリオン')
    end
  end

end
