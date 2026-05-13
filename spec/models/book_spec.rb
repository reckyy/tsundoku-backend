# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with factory defaults' do
    book = FactoryBot.build(:book)

    expect(book).to be_valid
  end

  it 'is invalid without a title' do
    book = FactoryBot.build(:book, title: nil)

    expect(book).not_to be_valid
  end

  it 'is invalid when title is blank' do
    book = FactoryBot.build(:book, title: '')

    expect(book).not_to be_valid
  end
end
