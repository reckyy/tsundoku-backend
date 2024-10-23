# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyReadingLogResource, type: :resource do
  before do
    @user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user_book = FactoryBot.create(:user_book, user: @user, book:)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    @reading_logs = FactoryBot.create_list(:reading_log, 2, memo:)
  end

  it 'returns the daily reading logs' do
    reading_log_json = DailyReadingLogResource.new(@user).serialize
    expected_reading_log_json = {
      logs: @reading_logs.sort_by(&:read_date).map do |log|
        {
          date: log.read_date.to_s,
          count: 1
        }
      end
    }.to_json
    expect(reading_log_json).to eq(expected_reading_log_json)
  end
end
