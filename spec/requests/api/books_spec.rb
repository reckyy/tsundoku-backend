# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Books', type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'test1@example.com')
  end

  describe 'Api::BooksController#index' do
    context 'params is valid' do
      it 'return a successful response' do
        params = { email: @user.email }
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

  describe 'Api::BooksController#create' do
    context 'params is valid' do
      it 'return a successful response' do
        book_params = { book: { title: 'テスト本のタイトル', author: 'テスト本の著者', cover_image_url: 'http://localhost:3000/testcoverimageurl' }, email: @user.email, heading_number: 5 }
        post api_books_path, params: book_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'params is not valid' do
      it 'return a bad response' do
        book_params = { book: { title: 'テスト本のタイトル', author: 'テスト本の著者' }, email: @user.email }
        post api_books_path, params: book_params
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
