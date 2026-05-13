# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:user_book) { UserBook.create!(user:, book:) }
  let(:heading) { Heading.create!(user_book:, number: 1, title: '') }

  it 'is valid with a heading' do
    memo = FactoryBot.build(:memo, heading:)

    expect(memo).to be_valid
  end

  it 'is invalid without a heading' do
    memo = FactoryBot.build(:memo, heading: nil)

    expect(memo).not_to be_valid
  end
end
