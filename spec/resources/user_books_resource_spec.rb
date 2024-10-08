# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBooksResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    @user_books = FactoryBot.create_list(:user_book, 2, user: @user)
  end

  it 'returns books' do
    user_books_json = UserBooksResource.new(@user).serialize
    expected_user_books_json = {
      books: @user_books.map do |ub|
        {
          id: ub.book.id,
          title: ub.book.title,
          author: ub.book.author,
          coverImageUrl: ub.book.cover_image_url
        }
      end
    }.to_json
    expect(user_books_json).to eq(expected_user_books_json)
  end
end
