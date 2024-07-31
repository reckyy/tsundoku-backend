# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::ReadingLogs', type: :request do
  before do
    @memo = FactoryBot.create(:memo)
  end

  describe 'Api::ReadingLogsController#create' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { memo_id: @memo.id }
        patch(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
