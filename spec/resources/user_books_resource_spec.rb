# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBooksResource, type: :resource do
  it 'returns user_books' do
    user = FactoryBot.create(:user)
    books = FactoryBot.create_list(:book, 3)
    books.each_with_index { |book, i| UserBook.create(user:, book:, status: i) }
    user_books = user.user_books
    categorized_user_books = CategorizedUserBooks.new(user_books.status_unread, user_books.status_reading, user_books.status_finished)
    user_books_json = UserBooksResource.new(categorized_user_books).serializable_hash.to_json
    expected_user_books_json = {
      unread_books: [
        {
          id: user_books[0].id,
          status: user_books[0].status,
          book: {
            id: user_books[0].book.id,
            title: user_books[0].book.title,
            author: user_books[0].book.author,
            coverImageUrl: user_books[0].book.cover_image_url
          }
        }
      ],
      reading_books: [
        {
          id: user_books[1].id,
          status: user_books[1].status,
          book: {
            id: user_books[1].book.id,
            title: user_books[1].book.title,
            author: user_books[1].book.author,
            coverImageUrl: user_books[1].book.cover_image_url
          }
        }
      ],
      finished_books: [
        {
          id: user_books[2].id,
          status: user_books[2].status,
          book: {
            id: user_books[2].book.id,
            title: user_books[2].book.title,
            author: user_books[2].book.author,
            coverImageUrl: user_books[2].book.cover_image_url
          }
        }
      ]
    }.to_json
    expect(user_books_json).to eq(expected_user_books_json)
  end
end
