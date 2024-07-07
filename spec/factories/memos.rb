# frozen_string_literal: true

FactoryBot.define do
  factory :memo do
    body { 'MyText' }
    heading { nil }
  end
end
