# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    avatar_url { 'https://hogehoge-image' }
  end
end
