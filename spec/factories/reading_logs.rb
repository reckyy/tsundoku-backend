# frozen_string_literal: true

FactoryBot.define do
  factory :reading_log do
    read_date { Faker::Date.on_day_of_week_between(day: :monday, from: 1.year.ago, to: '2024-07-21') }
    memo
  end
end
