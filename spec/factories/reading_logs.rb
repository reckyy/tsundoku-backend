# frozen_string_literal: true

FactoryBot.define do
  factory :reading_log do
    read_date { Time.zone.today }
  end
end
