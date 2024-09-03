# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    avatar_url { 'https://hogehoge-image' }
    uid { Faker::IdNumber.south_african_id_number }
    handle_name { Faker::Name.name }
  end
end
