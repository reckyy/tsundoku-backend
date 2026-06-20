# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :author, :cover_image_url, presence: true

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books
end
