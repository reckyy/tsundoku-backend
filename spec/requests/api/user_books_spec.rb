# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API::UserBooks', type: :request do
  let(:current_user) { @user_book.user }

  before do
    @user_book = FactoryBot.create(:user_book)
    authorization_stub
  end

  describe 'API::UserBooksController#move_position' do
    context 'params is valid' do
      it 'succeeds in swaping the position' do
        expect(@user_book.position).to eq(1)
        second_user_book = FactoryBot.create(:user_book, user: @user_book.user)
        expect(second_user_book.position).to eq(2)
        params = { book_id: @user_book.book.id, destination_book_id: second_user_book.book.id }
        post(move_position_api_user_books_path, params:)
        @user_book.reload
        expect(@user_book.position).to eq(2)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'API::UserBooksController#destroy' do
    context 'params is valid' do
      it 'return a nocontent response' do
        params = { book_id: @user_book.book.id }
        delete(api_user_book_path(@user_book.user.id), params:)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
