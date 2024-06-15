# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with title, author and cover_image_url' do
    book = FactoryBot.build(:book)
    expect(book).to be_valid
  end

  it 'is invalid without title' do
    book = FactoryBot.build(:book, title: nil)
    expect(book).to be_invalid
  end

  it 'is invalid without author' do
    book = FactoryBot.build(:book, author: nil)
    expect(book).to be_invalid
  end

  it 'is invalid without cover_image_url' do
    book = FactoryBot.build(:book, cover_image_url: nil)
    expect(book).to be_invalid
  end
end
