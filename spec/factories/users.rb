# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'hoge' }
    sequence(:email) { |n| "test#{n}@example.com" }
    avatar_url { 'https://hogehoge-image' }
    sequence(:uid) { |n| "0000000000#{n}" }
  end
end
