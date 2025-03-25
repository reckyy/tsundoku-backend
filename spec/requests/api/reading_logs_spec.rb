# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::ReadingLogs', type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  before do
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user: current_user, book:)
    heading = FactoryBot.create(:heading, user_book:)
    @memo = FactoryBot.create(:memo, heading:)
    FactoryBot.create(:reading_log, memo: @memo)
    authorization_stub
  end

  describe 'API::ReadingLogsController#index' do
    context 'params is valid' do
      it 'returns logs with date and count set' do
        get(api_reading_logs_path)
        expect(response).to have_http_status(:ok)
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
