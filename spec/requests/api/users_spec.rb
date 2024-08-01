# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  describe 'Api::UsersController#create' do
    context 'params is valid' do
      it 'return a successful response' do
        user_params = { name: 'hoge', email: 'hogehoge@example.com', avatar_url: 'https://hogehoge', uid: '00000000001' }
        post api_auth_callback_google_path, params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is not valid' do
      it 'return a bad response' do
        user_params = { user: { name: 'hoge', avatar_url: 'https://hogehoge' } }
        post api_auth_callback_google_path, params: user_params
        expect(response).to have_http_status(:internal_server_error)
      end
    end

    describe 'Api::UsersController#destroy' do
      context 'params is valid' do
        it 'return a nocontent response' do
          user = FactoryBot.create(:user)
          params = { uid: user.uid }
          delete("/api/users/#{user.uid}", params:)
          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
