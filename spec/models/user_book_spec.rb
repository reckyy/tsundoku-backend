# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBook, type: :model do
  it 'is invalid with a duplicate record' do
    user_book = FactoryBot.create(:user_book)
    duplicate_user_book = UserBook.new(user: user_book.user, book: user_book.book)
    expect(duplicate_user_book).to be_invalid
  end

  it '#swap_positions_with' do
    user_book = FactoryBot.create(:user_book)
    second_user_book = FactoryBot.create(:user_book)
    expect(user_book.position).to eq(1)
    expect(second_user_book.position).to eq(2)
    user_book.swap_positions_with(second_user_book)
    expect(second_user_book.position).to eq(1)
    expect(user_book.position).to eq(2)
  end
end
