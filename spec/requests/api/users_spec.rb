# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  describe 'Api::UsersController' do
    context 'params is valid' do
      it 'return a successful response' do
        user_params = { user: { name: 'hoge', email: 'hogehoge@example.com', avatar_url: 'https://hogehoge' } }
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
  end
end
