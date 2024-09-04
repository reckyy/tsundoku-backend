# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    avatar_url { 'https://hogehoge-image' }
    handle_name { Faker::Name.unique.middle_name }
  end
end
