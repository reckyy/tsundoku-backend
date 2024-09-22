# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Memos', type: :request do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:reading_log)
  end

  describe 'API::MemosController#index' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { user_id: @user.id }
        get(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
