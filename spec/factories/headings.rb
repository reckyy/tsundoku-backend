# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    sequence(:number) { |n| n }
    title { '章のタイトル' }
  end
end
