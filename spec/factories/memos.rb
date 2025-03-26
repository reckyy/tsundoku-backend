# frozen_string_literal: true

FactoryBot.define do
  factory :memo do
    sequence(:body) { |n| "本#{n}のメモ" }
  end
end
