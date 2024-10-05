# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    user_book = FactoryBot.create(:user_book)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    @reading_log = FactoryBot.create(:reading_log, memo:)
    @user = user_book.user
    @book = user_book.book
  end

  describe '#info' do
    it 'returns user books and logs' do
      expected_logs = [{ date: @reading_log.read_date.to_s.to_s, count: 1 }]
      expected_result = { books: @user.books, logs: expected_logs }

      expect(@user.info).to eq(expected_result)
    end
  end

  describe '#books_with_user_id' do
    it 'returns book with user_id' do
      expected_result = [{ id: @book.id, title: @book.title, author: @book.author, coverImageUrl: @book.cover_image_url, user_id: @user.id }]
      expect(@user.books_with_user_id).to eq(expected_result)
    end
  end
end
