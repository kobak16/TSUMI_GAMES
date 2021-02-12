require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'POST #create' do

    context 'ゲーム登録成功' do
      it '必要な項目が正しく入力される' do
        expect(build(:game)).to be_valid
      end
    end
    
    context 'ゲーム登録失敗' do
      it 'タイトルが未入力' do
        expect(build(:game, title: nil)).to_not be_valid
      end
      it 'プラットフォームが未選択' do
        expect(build(:game, machine: nil)).to_not be_valid  
      end
      it 'ジャンルが未選択' do
        expect(build(:game, genre: nil)).to_not be_valid
      end
    end
    
  end
end
