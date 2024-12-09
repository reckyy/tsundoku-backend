# frozen_string_literal: true

class DailyReadingLogResource < BaseResource
  attribute :logs do |user|
    first_year = user.reading_logs.first.read_date.year
    years = (first_year..Time.current.year).to_a
    years.index_with do |year|
      user.reading_logs
          .where(read_date: Time.zone.local(year).all_year)
          .group(:read_date)
          .count
          .map { |date, count| { date: date.to_s, count: } }
    end
  end
end
