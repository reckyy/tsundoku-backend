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
    end

    it 'returns unauthorized when the token is invalid' do
      get api_reading_logs_path, headers: { Authorization: 'Bearer invalid.token' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized when the token user does not exist' do
      token = JWT.encode({ id: -1 }, secret_key, 'HS256')

      get api_reading_logs_path, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized when the token is expired' do
      token = JWT.encode({ id: user.id, exp: 1.minute.ago.to_i }, secret_key, 'HS256')

      get api_reading_logs_path, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns ok when the token is valid' do
      token = JWT.encode({ id: user.id, exp: 30.days.from_now.to_i }, secret_key, 'HS256')

      get api_reading_logs_path, headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/auth/callback/google' do
    let(:audience) { 'test-audience' }
    let(:issuer) { 'https://accounts.google.com' }
    let(:claims) { { 'email' => user.email, 'name' => user.name, 'picture' => user.avatar_url } }

    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with('AUDIENCE').and_return(audience)
      allow(ENV).to receive(:fetch).with('ISSUER').and_return(issuer)
    end

    it 'returns ok when the Google ID token is verified' do
      allow(Google::Auth::IDTokens).to receive(:verify_oidc)
        .with('valid_token', aud: audience, iss: issuer)
        .and_return(claims)

      post api_auth_callback_google_path, params: { id_token: 'valid_token' }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['access_token']).to be_present
    end

    it 'returns unauthorized when the Google ID token verification fails' do
      allow(Google::Auth::IDTokens).to receive(:verify_oidc)
        .and_raise(Google::Auth::IDTokens::VerificationError)

      expect { post api_auth_callback_google_path, params: { id_token: 'tampered_token' } }
        .not_to(change { User.count })

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
