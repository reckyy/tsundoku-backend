# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Books', type: :request do
  let(:current_user) { FactoryBot.create(:user) }

  before do
    authorization_stub
  end

  describe 'API::BooksController#create' do
    context 'params is valid' do
      it 'returns a successful response' do
        params = { title: 'テスト本のタイトル', author: 'テスト本の著者', coverImageUrl: Faker::Internet.url }
        expect { post(api_books_path, params:) }.to change { Book.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is invalid' do
      it 'returns a bad response' do
        params = { title: '', author: 'テスト本の著者', coverImageUrl: Faker::Internet.url }
        post(api_books_path, params:)
        expect(response).to have_http_status(422)
      end
    end
  end
end
