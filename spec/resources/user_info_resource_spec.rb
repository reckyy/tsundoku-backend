# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInfoResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    books = FactoryBot.create_list(:book, 2)
    @user_books = books.map { |book| UserBook.create(user: @user, book:) }
    heading = FactoryBot.create(:heading, user_book: @user_books.first)
    memo = FactoryBot.create(:memo, heading:)
    @reading_log = FactoryBot.create(:reading_log, memo:)
  end

  it 'returns name, books and logs combined' do
    user_info_json = UserInfoResource.new(@user).serializable_hash.to_json
    expected_user_info_json = {
      name: @user.name,
      user_books: {
        unread_books: @user_books.map do |ub|
          {
            id: ub.id,
            status: ub.status,
            book: {
              id: ub.book.id,
              title: ub.book.title,
              author: ub.book.author,
              coverImageUrl: ub.book.cover_image_url
            }
          }
        end,
        reading_books: [],
        finished_books: []
      },
      logs: {
        @reading_log.read_date.year.to_s => [
          date: @reading_log.read_date,
          count: 1
        ]
      }
    }.to_json

    expect(user_info_json).to eq(expected_user_info_json)
  end
end
