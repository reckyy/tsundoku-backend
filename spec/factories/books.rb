# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'テスト本のタイトル' }
    author { 'テスト本の著者' }
    cover_image_url { 'http://localhost:3000/testimageurl' }
  end
end
