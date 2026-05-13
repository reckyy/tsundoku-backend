# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingLog, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  let(:user_book) { UserBook.create!(user:, book:) }
  let(:heading) { Heading.create!(user_book:, number: 1, title: '') }
  let(:memo) { Memo.create!(heading:) }

  it 'is valid with factory defaults' do
    reading_log = FactoryBot.build(:reading_log, memo:)

    expect(reading_log).to be_valid
  end

  it 'is invalid without a read_date' do
    reading_log = FactoryBot.build(:reading_log, memo:, read_date: nil)

    expect(reading_log).not_to be_valid
  end

  it 'is invalid without a memo' do
    reading_log = FactoryBot.build(:reading_log, memo: nil)

    expect(reading_log).not_to be_valid
  end

  it 'is invalid when memo and read_date duplicate an existing record' do
    FactoryBot.create(:reading_log, memo:, read_date: Date.new(2026, 5, 1))
    duplicate = FactoryBot.build(:reading_log, memo:, read_date: Date.new(2026, 5, 1))

    expect(duplicate).not_to be_valid
  end

  it 'is valid when same memo has a different read_date' do
    FactoryBot.create(:reading_log, memo:, read_date: Date.new(2026, 5, 1))
    different_date = FactoryBot.build(:reading_log, memo:, read_date: Date.new(2026, 5, 2))

    expect(different_date).to be_valid
  end
end
