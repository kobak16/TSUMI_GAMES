require 'rails_helper'

RSpec.describe "Games", type: :request do

  describe 'GET #index' do
    before do
      create :game1
      get games_path
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'ゲーム名が表示されること' do
      expect(response.body).to include 'ウイニングポスト9'
    end
  end

  describe 'GET #show' do
    let(:user1) { create :user1 }
    let(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
      get game_path(game1.id)
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'ゲーム名が表示されること' do
      expect(response.body).to include game1.title
    end
  end

  describe 'GET #new' do
    let(:user1) { create :user1 } 
    it 'リクエストが成功すること' do
      sign_in user1
      get new_game_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:user1) { create :user1 } 
    before do
      sign_in user1
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post games_path, params: { game: attributes_for(:game1) }
        expect(response.status).to eq 302
      end
      it 'ゲームが登録されること' do
        expect do
          post games_path, params: { game: attributes_for(:game1) }
        end.to change(Game, :count).by(1)
      end
      it 'リダイレクトすること' do
        post games_path, params: { game: attributes_for(:game1) }
        redirect_to user_path(user1.id)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post games_path, params: { game: attributes_for(:game1, title: nil) }
        expect(response.status).to eq 200
      end
      it 'ゲームが登録されないこと' do
        expect do
          post games_path, params: { game: attributes_for(:game1, title: nil) }
        end.to_not change(Game, :count)
      end
      it 'エラーが表示されること' do
        post games_path, params: { game: attributes_for(:game1, title: nil) }
        expect(response.body).to include '入力してください'
      end
    end
  end
  
  describe 'GET #edit not_cleared' do
    let(:user1) { create :user1 }
    let(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
      get edit_game_path(game1.id, name: 'not_cleared')
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'タイトルが表示されていること' do
      expect(response.body).to include game1.title
    end
    it '変更ボタンが表示されていること' do
      expect(response.body).to include '変更する'
    end
  end

  describe 'PUT #update not_cleared' do
    let(:user1) { create :user1 }
    let(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2) }
        expect(response.status).to eq 302
      end
      it 'タイトルが変更されること' do
        expect do
          put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2) }
        end.to change { Game.find(game1.id).title }.from('ウイニングポスト9').to('ダービースタリオン')
      end
      it 'リダイレクトすること' do
        put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2) }
        expect(response).to redirect_to game_path(game1.id)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2, title: nil) }
        expect(response.status).to eq 200
      end
      it 'タイトルが変更されないこと' do
        expect do
          put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2, title: nil) }
        end.to_not change(Game.find(game1.id), :title)
      end
      it 'エラーが表示されること' do
        put game_path(game1.id, name: 'not_cleared'), params: { game: attributes_for(:game2, title: nil) }
        expect(response.body).to include '入力してください'
      end
    end
  end
  
  describe 'GET #edit cleared' do
    let(:user1) { create :user1 }
    let(:game1) { create :game1, user_id: user1.id, status: 1, clear_day: Time.current.tomorrow }
    before do
      sign_in user1
      get edit_game_path(game1.id, name: 'cleared')
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'タイトルが表示されていること' do
      expect(response.body).to include game1.title
    end
    it '更新ボタンが表示されていること' do
      expect(response.body).to include '更新する'
    end
  end

  describe 'PUT #update cleared' do
    let(:user1) { create :user1 } 
    let(:game1) { create :game1, user: user1, status: 1, clear_day: Time.current.tomorrow }
    before do
      sign_in user1
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2) }
        expect(response.status).to eq 302
      end
      it 'タイトルが更新されること' do
        expect do
          put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2) }
        end.to change { Game.find(game1.id).title }.from('ウイニングポスト9').to('ダービースタリオン')
      end
      it 'リダイレクトすること' do
        put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2) }
        expect(response).to redirect_to game_path(game1.id)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2, title: nil) }
        expect(response.status).to eq 200
      end
      it 'タイトルが更新されないこと' do
        expect do
          put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2, title: nil) }
        end.to_not change(Game.find(game1.id), :title)
      end
      it 'エラーが表示されること' do
        put game_path(game1.id, name: 'cleared'), params: { game: attributes_for(:game2, title: nil) }
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'GET #edit clear' do
    let(:user1) { create :user1 }
    let(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
      get edit_game_path(game1.id, name: 'clear')
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'タイトルが表示されていること' do
      expect(response.body).to include game1.title
    end
    it '登録ボタンが表示されていること' do
      expect(response.body).to include '登録'
    end
  end

  describe 'PUT #update clear' do
    let(:user1) { create :user1 } 
    let(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        expect(response.status).to eq 302
      end
      it 'コメントが登録されること' do
        expect do
          put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        end.to change { Game.find(game1.id).comment }.from(nil).to('メガンテ')
      end
      it 'リダイレクトすること' do
        put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        expect(response).to redirect_to game_path(game1.id)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, title: nil, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        expect(response.status).to eq 200
      end
      it 'コメントが登録されないこと' do
        expect do
          put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, title: nil, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        end.to_not change(Game.find(game1.id), :comment)
      end
      it 'エラーが表示されること' do
        put game_path(game1.id, name: 'clear'), params: { game: attributes_for(:game1, title: nil, status: 1, clear_day: Time.current.tomorrow, comment: 'メガンテ') }
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user1) { create :user1 }
    let!(:game1) { create :game1, user: user1 }
    before do
      sign_in user1
    end
    it 'リクエストが成功すること' do
      delete game_path(game1.id)
      expect(response.status).to eq 302
    end
    it 'ゲームが削除されること' do
      expect do
        delete game_path(game1.id)
      end.to change(Game, :count).by(-1) 
    end
    it 'リダイレクトすること' do
      delete game_path(game1.id)
      expect(response).to redirect_to user_path(user1.id)
    end
  end
  
end
