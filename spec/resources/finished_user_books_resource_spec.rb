# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FinishedUserBooksResource, type: :resource do
  before do
    @user_book = FactoryBot.create(:user_book, status: 2)
  end

  it 'returns user_books whose status is finished' do
    finished_user_books_json = FinishedUserBooksResource.new(@user_book.user).serialize
    expected_finished_user_books_json = {
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
    expect(finished_user_books_json).to eq(expected_finished_user_books_json)
  end
end
