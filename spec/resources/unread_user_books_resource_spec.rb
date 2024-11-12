# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnreadUserBooksResource, type: :resource do
  before do
    @user_book = FactoryBot.create(:user_book)
  end

  it 'returns user_books whose status is unread' do
    unread_user_books_json = UnreadUserBooksResource.new(@user_book.user).serialize
    expected_unread_user_books_json = {
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
    expect(unread_user_books_json).to eq(expected_unread_user_books_json)
  end
end
