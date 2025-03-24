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
        user_params = { name: 'hoge', email: 'hogehoge@example.com', avatar_url: 'https://hogehoge' }
        post api_auth_callback_google_path, params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when a user logs in' do
      it 'returns a ok response' do
        user_params = { name: current_user.name, email: current_user.email, avatar_url: current_user.avatar_url }
        post api_auth_callback_google_path, params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is invalid' do
      it 'returns a bad response' do
        user_params = { name: 'hoge', avatar_url: 'https://hogehoge' }
        post api_auth_callback_google_path, params: user_params
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
        delete("/api/users/#{current_user.id}")
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
