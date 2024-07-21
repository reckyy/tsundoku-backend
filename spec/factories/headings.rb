# frozen_string_literal: true

FactoryBot.define do
  factory :heading do
    number { 1 }
    title { '章のタイトル' }
    user_book
  end
end
