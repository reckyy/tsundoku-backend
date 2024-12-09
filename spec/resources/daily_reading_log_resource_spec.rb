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
    first_year = @reading_logs.min_by(&:read_date).read_date.year
    expected_reading_log_json = {
      logs: (first_year..Time.current.year).to_a.to_h do |year|
        [
          year.to_s,
          @reading_logs
            .select { |log| log.read_date.year == year }
            .group_by(&:read_date)
            .sort
            .map { |date, logs| { date: date.to_s, count: logs.size } }
        ]
      end
    }.to_json

    expect(reading_log_json).to eq(expected_reading_log_json)
  end
end
