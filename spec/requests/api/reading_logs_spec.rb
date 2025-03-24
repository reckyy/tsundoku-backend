# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::ReadingLogs', type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  before do
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user: current_user, book:)
    heading = FactoryBot.create(:heading, user_book:)
    @memo = FactoryBot.create(:memo, heading:)
    @reading_log = FactoryBot.create(:reading_log, memo: @memo)
    authorization_stub
  end

  describe 'API::ReadingLogsController#index' do
    context 'params is valid' do
      it 'returns logs with date and count set' do
        get(api_reading_logs_path)
        expect(response).to have_http_status(:ok)
        reading_log_year = @reading_log.read_date.year
        expected_response_json = { logs: { "#{reading_log_year}": [{ date: @reading_log.read_date.to_s, count: 1 }] } }
        expect(response.body).to eq(expected_response_json.to_json)
      end
    end
  end

  describe 'API::ReadingLogsController#create' do
    context 'params is valid' do
      it 'returns a successful response' do
        params = { memo_id: @memo.id }
        post(api_reading_logs_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is invalid' do
      it 'returns a bad response' do
        params = { memo_id: -1 }
        post(api_reading_logs_path, params:)
        expect(response).to have_http_status(422)
      end
    end
  end
end
