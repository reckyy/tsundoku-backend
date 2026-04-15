# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heading, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:user_book) { UserBook.create!(user:, book:) }

  it 'is invalid without a number' do
    heading = FactoryBot.build(:heading, user_book:, number: nil)

    expect(heading).not_to be_valid
  end

  it 'is invalid when number is zero' do
    heading = FactoryBot.build(:heading, user_book:, number: 0)

    expect(heading).not_to be_valid
  end

  it 'is invalid when number is negative' do
    heading = FactoryBot.build(:heading, user_book:, number: -1)

    expect(heading).not_to be_valid
  end

  it 'is valid when number is a positive integer' do
    heading = FactoryBot.build(:heading, user_book:, number: 1)

    expect(heading).to be_valid
  end
end
