# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::UserBooks', type: :request do
  before do
    @user_book = FactoryBot.create(:user_book)
  end

  describe 'Api::UserBooksController#destroy' do
    context 'params is valid' do
      it 'return a nocontent response' do
        params = { book_id: @user_book.book.id, uid: @user_book.user.uid }
        delete(api_user_book_path(@user_book.user.id), params:)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
