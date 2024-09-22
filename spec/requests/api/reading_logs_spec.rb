# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::ReadingLogs', type: :request do
  before do
    @memo = FactoryBot.create(:memo)
    @user = @memo.heading.user_book.user
    @reading_log = FactoryBot.create(:reading_log, memo: @memo)
  end

  describe 'API::ReadingLogsController#index' do
    context 'params is valid' do
      it 'return logs with date and count set' do
        params = { user_id: @user.id }
        get(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq([{ date: @reading_log.read_date.to_s, count: 1 }].to_json)
      end
    end
  end

  describe 'API::ReadingLogsController#create' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { user_id: @user.id, memo_id: @memo.id }
        post(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
