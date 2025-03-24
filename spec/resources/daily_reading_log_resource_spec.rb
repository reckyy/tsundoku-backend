# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyReadingLogResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user: @user, book:)
    heading = FactoryBot.create(:heading, user_book:)
    @memo = FactoryBot.create(:memo, heading:)
  end

  it 'returns the daily reading logs' do
    last_year = 1.year.ago
    last_year_reading_log = ReadingLog.create(memo: @memo, read_date: last_year)
    reading_log = FactoryBot.create(:reading_log, memo: @memo)
    reading_log_json = DailyReadingLogResource.new(@user).serializable_hash.to_json
    expected_reading_log_json = {
      logs: {
        last_year_reading_log.read_date.year.to_s => [
          date: last_year_reading_log.read_date,
          count: 1
        ],
        reading_log.read_date.year.to_s => [
          date: reading_log.read_date,
          count: 1
        ]
      }
    }.to_json
    expect(reading_log_json).to eq(expected_reading_log_json)
  end

  it 'returns the empty log when user does not have reading logs' do
    new_user = FactoryBot.create(:user)
    reading_log_json = DailyReadingLogResource.new(new_user).serializable_hash.to_json
    expected_reading_log_json = { logs: {} }.to_json

    expect(reading_log_json).to eq(expected_reading_log_json)
  end
end
