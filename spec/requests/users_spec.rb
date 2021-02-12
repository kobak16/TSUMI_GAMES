require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'GET #index' do
    before do
      create :user1
      get users_path
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'ユーザー名が表示されること' do
      expect(response.body).to include 'user1'
    end 
  end

  describe 'GET #show' do
    let(:user1) { create :user1 }
    context 'ゲームが存在する場合' do
      before do
        @game = create(:game1, user: user1)
        sign_in user1
        get user_path user1.id
      end
      let(:game1) { create :game1, user: user1 }
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ユーザー詳細が表示されていること' do
        expect(response.body).to include 'ユーザー詳細'
      end
      it 'ゲームタイトルが表示されること' do
        expect(response.body).to include @game.title
      end
    end
    context 'ゲームが存在しない場合' do
      before do
        sign_in user1
        get user_path user1.id
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ユーザー詳細が表示されていること' do
        expect(response.body).to include 'ユーザー詳細'
      end
      it '未クリアが表示されること' do
        expect(response.body).to include '未クリアのゲームはありません'
      end
    end
  end


  describe 'GET #mygames' do
    let(:user1) { create :user1 }
    context 'ゲームが存在する場合' do
      before do
        @game = create(:game1, user: user1)
        sign_in user1
        get mygames_user_path(user1.id, name: 'all')
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ゲーム名が表示されていること' do
        expect(response.body).to include @game.title
      end
    end
    context 'ゲームが存在しない場合' do
      before do
        sign_in user1
        get mygames_user_path(user1.id, name: 'all')
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ゲームが表示されないこと' do
        expect(response.body).to include '該当するゲームはありません'
      end
    end
  end

  describe 'GET #followings' do
    let(:user1) { create :user1 }
    context 'フォローが存在する場合' do
      let(:user2) { create :user2 }
      before do
        user1.following_relationships.create(following_id: user2.id)
        sign_in user1
        get followings_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'フォローしているユーザー名が表示されること' do
        expect(response.body).to include user2.username
      end
    end
    describe 'フォローが存在しない場合' do
      before do
        sign_in user1
        get followings_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'フォローしているユーザーが表示されないこと' do
        expect(response.body).to include '該当するユーザーはいません'
      end
    end
  end

  describe 'GET #followers' do
    let(:user1) { create :user1 }
    context 'フォロワーが存在する場合' do
      let(:user2) { create :user2 }
      before do
        user2.following_relationships.create(following_id: user1.id)
        sign_in user1
        get followers_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'フォロワー名が表示されること' do
        expect(response.body).to include user2.username
      end
    end
    describe 'フォロワーが存在しない場合' do
      before do
        sign_in user1
        get followers_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'フォロワーが表示されないこと' do
        expect(response.body).to include '該当するユーザーはいません'
      end
    end
  end
  
  describe 'GET #likes' do
    let(:user1) { create :user1 }
    context '気になるゲームが存在する場合' do
      let(:other_user) { create :user2 }
      let(:game1) { create :game1, user: other_user }
      before do
        Like.create(user_id: user1.id, game_id: game1.id)
        sign_in user1
        get likes_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ゲームタイトルが表示されること' do
        expect(response.body).to include game1.title
      end
    end
    context '気になるゲームが存在しない場合' do
      before do
        sign_in user1
        get likes_user_path(user1.id)
      end
      it 'リクエストが成功すること' do
        expect(response.status).to eq 200
      end
      it 'ゲームが表示されないこと' do
        expect(response.body).to include '該当するゲームはありません'
      end
    end
  end
  

end