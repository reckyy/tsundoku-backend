# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Users', type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  before do
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user: current_user, book:)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    FactoryBot.create(:reading_log, memo:)
    authorization_stub
  end

  describe 'API::UsersController#create' do
    context 'registering new user' do
      it 'returns a ok response' do
        google_id_token_stub('email' => Faker::Internet.email, 'name' => 'hoge', 'picture' => Faker::Internet.url)
        expect { post api_auth_callback_google_path, params: { id_token: 'id_token' } }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['access_token']).to be_present
        expect(response.parsed_body['access_token_expires_at']).to be_present
      end
    end

    context 'when a user logs in' do
      it 'returns a ok response' do
        expect { post api_auth_callback_google_path, params: { id_token: 'id_token' } }.not_to(change { User.count })
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['access_token']).to be_present
        expect(response.parsed_body['access_token_expires_at']).to be_present
      end
    end

    context 'when an existing user logs in with a changed name and avatar' do
      it 'updates the profile without creating a new user' do
        google_id_token_stub('email' => current_user.email, 'name' => 'new name', 'picture' => 'https://example.com/new-avatar.png')
        expect { post api_auth_callback_google_path, params: { id_token: 'id_token' } }.not_to(change { User.count })
        expect(response).to have_http_status(:ok)
        expect(current_user.reload.name).to eq 'new name'
        expect(current_user.avatar_url).to eq 'https://example.com/new-avatar.png'
      end
    end

    context 'when the request body email differs from the token email' do
      it 'identifies the user by the token email' do
        user_params = { name: 'attacker', email: 'attacker@example.com', avatar_url: Faker::Internet.url, id_token: 'id_token' }
        expect { post api_auth_callback_google_path, params: user_params }.not_to(change { User.count })
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['id']).to eq current_user.id
        expect(User.exists?(email: 'attacker@example.com')).to be false
      end
    end

    context 'when token claims lack an email' do
      it 'returns a bad response' do
        google_id_token_stub('email' => nil, 'name' => 'hoge', 'picture' => Faker::Internet.url)
        post api_auth_callback_google_path, params: { id_token: 'id_token' }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'API::UsersController#show' do
    context 'params is valid' do
      it 'returns a user_info' do
        params = { id: current_user.id }
        get("/api/users/#{current_user.id}", params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'API::UsersController#destroy' do
    context 'params is valid' do
      it 'return a nocontent response' do
        expect { delete("/api/users/#{current_user.id}") }.to change { User.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when destroy fails' do
      it 'return a bad response' do
        allow(current_user).to receive(:destroy).and_return(false)
        delete("/api/users/#{current_user.id}")
        expect(response).to have_http_status(422)
      end
    end
  end
end
