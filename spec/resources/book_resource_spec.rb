# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookResource, type: :resource do
  before do
    @book = FactoryBot.create(:book)
  end

  it 'returns the attributes of the book' do
    book_json = BookResource.new(@book).serializable_hash.to_json
    expected_book_json = { id: @book.id, title: @book.title, author: @book.author, coverImageUrl: @book.cover_image_url }.to_json
    expect(book_json).to eq(expected_book_json)
  end
end
