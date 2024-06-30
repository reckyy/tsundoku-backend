# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    number { 1 }
    title { 'MyString' }
    user_book { nil }
  end
end
