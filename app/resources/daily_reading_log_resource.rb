# frozen_string_literal: true

class DailyReadingLogResource < BaseResource
  attribute :logs do |user|
    user.reading_logs.group(:read_date).count.map do |date, count|
      { date: date.to_s, count: }
    end
  end
end
