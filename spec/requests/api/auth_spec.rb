# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Auths', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'API::AuthController#add_session_user_data' do
    context 'params is valid' do
      it 'return a successful response' do
        user_params = { email: @user.email }
        get api_auth_add_session_user_data_path, params: user_params
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ id: @user.id.to_s }.to_json)
      end
    end
  end
end
