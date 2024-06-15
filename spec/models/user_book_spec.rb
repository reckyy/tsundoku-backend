# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  it 'is invalid with a duplicate record' do
    user_book = FactoryBot.create(:user_book)
    duplicate_user_book = UserBook.new(user: user_book.user, book: user_book.book)
    expect(duplicate_user_book).to be_invalid
  end
end
