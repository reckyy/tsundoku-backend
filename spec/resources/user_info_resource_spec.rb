# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInfoResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    @user_books = FactoryBot.create_list(:user_book, 2, user: @user)
    heading = FactoryBot.create(:heading, user_book: @user_books.first)
    memo = FactoryBot.create(:memo, heading:)
    @reading_logs = FactoryBot.create_list(:reading_log, 2, memo:)
  end

  it 'returns name, books and logs combined' do
    user_info_json = UserInfoResource.new(@user).serialize
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
      logs: @reading_logs.sort_by(&:read_date).map do |log|
        {
          date: log.read_date.to_s,
          count: 1
        }
      end
    }.to_json

    expect(user_info_json).to eq(expected_user_info_json)
  end
end
