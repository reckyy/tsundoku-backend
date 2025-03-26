# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Memos', type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  before do
    @book = FactoryBot.create(:book)
    user_book = UserBook.create(user: current_user, book: @book)
    heading = FactoryBot.create(:heading, user_book:)
    @memo = FactoryBot.create(:memo, heading:)
    authorization_stub
  end

  describe 'API::MemosController#index' do
    context 'params is valid' do
      it 'returns a successful response' do
        params = { book_id: @book.id }
        get(api_memos_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'API::MemosController#update' do
    context 'params is valid' do
      it 'returns a successful response and update the data successfully' do
        params = { id: @memo.id, body: '更新後のメモ' }
        patch(api_memo_path(@memo.id), params:)
        expect(response).to have_http_status(:ok)
        @memo.reload
        expect(@memo.body).to eq('更新後のメモ')
      end
    end

    context 'when update fails' do
      it 'returns a bad response' do
        allow_any_instance_of(Memo).to receive(:update).and_return(false)
        params = { id: @memo.id, body: '更新後のメモ' }
        patch(api_memo_path(@memo.id), params:)
        expect(response).to have_http_status(422)
      end
    end
  end
end
