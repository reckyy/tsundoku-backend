# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingUserBooksResource, type: :resource do
  before do
    @user_book = FactoryBot.create(:user_book, status: 1)
  end

  it 'returns user_books whose status is reading' do
    reading_user_books_json = ReadingUserBooksResource.new(@user_book.user).serialize
    expected_reading_user_books_json = {
      user_books: [{
        id: @user_book.id,
        status: @user_book.status,
        book: {
          id: @user_book.book.id,
          title: @user_book.book.title,
          author: @user_book.book.author,
          coverImageUrl: @user_book.book.cover_image_url
        }
      }]
    }.to_json
    expect(reading_user_books_json).to eq(expected_reading_user_books_json)
  end
end
