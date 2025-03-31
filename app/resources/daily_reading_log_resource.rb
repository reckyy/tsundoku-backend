# frozen_string_literal: true

class DailyReadingLogResource < BaseResource
  attribute :logs do |user|
    reading_logs = user.reading_logs

    if reading_logs.empty?
      {}
    else
      daily_counts = reading_logs
                     .group(:read_date)
                     .count
                     .transform_keys(&:to_date)
      logs_by_year = daily_counts.group_by { |date, _| date.year }
      logs_by_year[Time.current.year] ||= []

      logs_by_year.transform_values do |logs|
        logs.map { |date, count| { date: date.to_s, count: } }
      end
    end
  end
end
