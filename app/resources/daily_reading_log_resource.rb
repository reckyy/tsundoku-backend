# frozen_string_literal: true

class DailyReadingLogResource < BaseResource
  attribute :logs do |user|
    reading_logs = user.reading_logs
    first_reading_log = reading_logs.first

    if first_reading_log
      years = (first_reading_log.read_date.year..Time.current.year).to_a
      years.index_with do |year|
        reading_logs
          .where(read_date: Time.zone.local(year).all_year)
          .group(:read_date)
          .count
          .map { |date, count| { date: date.to_s, count: } }
      end
    else
      {}
    end
  end
end
