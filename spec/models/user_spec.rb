require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'POST #create' do

    context 'ユーザー登録成功' do
      it  '必要な項目が正しく入力される' do
        expect(build(:user)).to be_valid
      end
    end

    context 'ユーザー登録失敗' do
      it 'ユーザー名が未入力' do
        expect(build(:user, username: nil)).to_not be_valid
      end
      it 'ユーザー名が21文字以上' do
        expect(build(:user, username: "あいうえおかきくけこさしすせそたちつてとな")).to_not be_valid
      end
      it 'メールアドレスが未入力' do
        expect(build(:user, email: nil)).to_not be_valid
      end
      it 'メールアドレスが重複' do
        user = create(:user, email: "rspec_test@sample.com")
        user = build(:user, email: "rspec_test@sample.com")
        user.valid?
        expect(user.errors.messages[:email]).to include('はすでに存在します')
      end
      it '性別が未選択' do
        expect(build(:user, sex: nil)).to_not be_valid
      end
      it '年齢が未選択' do
        expect(build(:user, ages: nil)).to_not be_valid
      end
      it  '好きなゲームが30文字以上' do
        expect(build(:user, favorite: "吾輩は猫である。名前はまだ無い。どこで生れたかとんと見当がつかぬ。")).to_not be_valid
      end
      it 'パスワードが未入力' do
        expect(build(:user, password: nil)).to_not be_valid
      end
      it 'パスワードが5文字以下' do
        expect(build(:user, password: "abcde")).to_not be_valid
      end
    end

  end
end
