# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Memos', type: :request do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:reading_log)
  end

  describe 'GET /index' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { uid: @user.uid }
        get(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
