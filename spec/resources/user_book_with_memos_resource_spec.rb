# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBookWithMemosResource, type: :resource do
  it 'returns the attributes of the book' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user:, book:)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    user_book_with_memos_json = UserBookWithMemosResource.new(user_book).serializable_hash.to_json
    expected_book_json = {
      id: user_book.id,
      status: user_book.status,
      book: {
        id: book.id,
        title: book.title,
        author: book.author,
        coverImageUrl: book.cover_image_url
      },
      headings: [{
        id: heading.id,
        number: heading.number,
        title: heading.title,
        memo: {
          id: memo.id,
          body: memo.body
        }
      }]
    }.to_json
    expect(user_book_with_memos_json).to eq(expected_book_json)
  end
end
