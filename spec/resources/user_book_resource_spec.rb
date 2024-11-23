# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBookResource, type: :resource do
  before do
    @user_book = FactoryBot.create(:user_book)
  end

  it 'returns user_books' do
    user_book_json = UserBookResource.new(@user_book).serialize
    expected_user_book_json = {
      id: @user_book.id,
      status: @user_book.status,
      book: {
        id: @user_book.book.id,
        title: @user_book.book.title,
        author: @user_book.book.author,
        coverImageUrl: @user_book.book.cover_image_url
      }
    }.to_json
    expect(user_book_json).to eq(expected_user_book_json)
  end
end
