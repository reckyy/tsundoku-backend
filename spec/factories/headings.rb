# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    number { Faker::Number.between(from: 1, to: 10) }
    title { '章のタイトル' }
  end
end
