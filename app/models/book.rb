# frozen_string_literal: true

class Book < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :author
    validates :cover_image_url
  end

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books
end
