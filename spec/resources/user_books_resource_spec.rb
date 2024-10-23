# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBooksResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    @user_books = FactoryBot.create_list(:user_book, 2, user: @user)
  end

  it 'returns user_books' do
    user_books_json = UserBooksResource.new(@user).serialize
    expected_user_books_json = {
      user_books: @user_books.map do |ub|
        {
          id: ub.id,
          book: {
            id: ub.book.id,
            title: ub.book.title,
            author: ub.book.author,
            coverImageUrl: ub.book.cover_image_url
          }
        }
      end
    }.to_json
    expect(user_books_json).to eq(expected_user_books_json)
  end
end
