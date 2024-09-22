# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::Books', type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'test1@example.com')
  end

  describe 'API::BooksController#index' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { user_id: @user.id }
        get(api_books_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is not defined' do
      it 'return a blank array' do
        params = {}
        get(api_books_path, params:)
        expect(response.body).to include('[]')
      end
    end
  end

  describe 'API::BooksController#create' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { title: 'テスト本のタイトル', author: 'テスト本の著者', coverImageUrl: 'http://localhost:3000/testcoverimageurl', user_id: @user.id, headingNumber: 5 }
        post(api_books_path, params:)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is not valid' do
      it 'return a bad response' do
        params = { title: 'テスト本のタイトル', author: 'テスト本の著者', user_id: @user.id }
        post(api_books_path, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
