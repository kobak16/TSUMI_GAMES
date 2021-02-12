require 'rails_helper'

RSpec.describe "Devise", type: :request do
  
  describe 'GET sessions#new' do
    it 'リクエストが成功すること' do
      get new_user_session_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET registrations#new' do
    it 'リクエストが成功すること' do
      get new_user_registration_path
      expect(response.status).to eq 200
    end
  end

  describe 'POST registrations#create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: attributes_for(:user) }
        expect(response.status).to eq 302
      end
      it 'ユーザーが登録されること' do
        expect do
          post user_registration_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      it 'リダイレクトすること' do
        post user_registration_path, params: { user: attributes_for(:user) }
        redirect_to users_path(User.last)
      end
    end
    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: attributes_for(:user, username: nil) }
        expect(response.status).to eq 200
      end
      it 'ユーザーが登録されないこと' do
        expect do
          post user_registration_path, params: { user: attributes_for(:user, username: nil) }
        end.to_not change(User, :count)
      end
      it 'エラーが表示されること' do
        post user_registration_path, params: { user: attributes_for(:user, username: nil) }
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'GET registrations#edit' do
    let(:user1) { create :user1 }
    before do
      sign_in user1
      get edit_user_registration_path user1.id
    end
    it 'リクエストが成功すること' do
      expect(response.status).to eq 200
    end
    it 'ユーザー名が表示されていること' do
      expect(response.body).to include user1.username
    end
    it 'メールアドレスが表示されていること' do
      expect(response.body).to include 'rspec_user1@example.com'
    end
  end

  describe 'PUT registrations#upadte' do
    let(:user1) { create :user1 } 
    before do
      sign_in user1
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put user_registration_path, params: { user: attributes_for(:user2) }
        expect(response.status).to eq 302
      end
      it 'ユーザー名が更新されること' do
        expect do
          put user_registration_path, params: { user: attributes_for(:user2) }
        end.to change { User.find(user1.id).username }.from('user1').to('user2')
      end
      it 'リダイレクトすること' do
        put user_registration_path, params: { user: attributes_for(:user2) }
        expect(response).to redirect_to user_path(user1.id)
      end
    end
    context 'パラメータガ不正な場合' do
      it 'リクエストが成功すること' do
        put user_registration_path, params: { user: attributes_for(:user, username: nil) }
        expect(response.status).to eq 200
      end
      it 'ユーザー名が変更されないこと' do
        expect do
          put user_registration_path, params: { user: attributes_for(:user, username: nil) }
        end.to_not change(User.find(user1.id), :username)
      end
      it 'エラーが表示されること' do
        put user_registration_path, params: { user: attributes_for(:user, username: nil) }
        expect(response.body).to include '入力してください'
      end
    end
  end

  describe 'DELETE registrations#destroy' do
    let!(:user1) {create :user1}
    before do
      sign_in user1
    end
    it 'リクエストが成功すること' do
      delete user_registration_path
      expect(response.status).to eq 302
    end
    it 'ユーザーが削除されること' do
      expect do
        delete user_registration_path
      end.to change(User, :count).by(-1)  
    end
    it 'リダイレクトすること' do
      delete user_registration_path
      expect(response).to redirect_to root_path 
    end
  end

end