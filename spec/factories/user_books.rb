# frozen_string_literal: true

FactoryBot.define do
  factory :user_book do
    user
    book
  end
end
