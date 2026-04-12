# frozen_string_literal: true

require 'rails_helper'
require 'jwt'

RSpec.describe 'Authentication', type: :request do
  let(:secret_key) { ENV.fetch('SECRET_KEY_BASE') }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /api/reading_logs' do
    it 'returns unauthorized when the token is missing' do
      get api_reading_logs_path

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to eq('errors' => ['Not Authenticated'])
    end

    it 'returns unauthorized when the token is invalid' do
      get api_reading_logs_path, headers: { Authorization: 'Bearer invalid.token' }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to eq('errors' => ['Not Authenticated'])
    end

    it 'returns unauthorized when the token user does not exist' do
      token = JWT.encode({ id: -1 }, secret_key, 'HS256')

      get api_reading_logs_path, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body).to eq('errors' => ['Not Authenticated'])
    end

    it 'returns ok when the token is valid' do
      token = JWT.encode({ id: user.id }, secret_key, 'HS256')

      get api_reading_logs_path, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
    end
  end
end
