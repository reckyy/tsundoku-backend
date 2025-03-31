# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInfoResource, type: :resource do
  it 'returns name, books and logs combined' do
    user = FactoryBot.create(:user)
    books = FactoryBot.create_list(:book, 3)
    books.each_with_index { |book, i| UserBook.create(user:, book:, status: i) }
    user_books = user.user_books
    heading = FactoryBot.create(:heading, user_book: user_books.first)
    memo = FactoryBot.create(:memo, heading:)
    reading_log = FactoryBot.create(:reading_log, memo:)
    user_info_json = UserInfoResource.new(user).serializable_hash.to_json
    expected_user_info_json = {
      name: user.name,
      user_books: {
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
      },
      logs: {
        reading_log.read_date.year.to_s => [
          {
            date: reading_log.read_date.to_s,
            count: 1
          }
        ]
      }
    }.to_json

    expect(user_info_json).to eq(expected_user_info_json)
  end
end
