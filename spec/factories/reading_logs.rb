# frozen_string_literal: true

FactoryBot.define do
  factory :reading_log do
    read_date { Date.new(2024, 7, 21) }
    memo
  end
end
