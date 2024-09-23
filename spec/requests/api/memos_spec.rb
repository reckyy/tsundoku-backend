# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Memos', type: :request do
  before do
    @user = FactoryBot.create(:user)
    reading_log = FactoryBot.create(:reading_log)
    @memo = reading_log.memo
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

  describe 'API::MemosController#update' do
    context 'params is valid' do
      it 'return a successful response and update the data successfully' do
        params = { memo: { id: @memo.id, body: '更新後のメモ' }, user_id: @user.id }
        patch(api_memo_path(@memo.id), params:)
        expect(response).to have_http_status(:ok)
        @memo.reload
        expect(@memo.body).to eq('更新後のメモ')
      end
    end
  end
end
