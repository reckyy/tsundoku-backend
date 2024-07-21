# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :email, uniqueness: true
    validates :avatar_url
    validates :uid
  end

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :headings, through: :user_books
  has_many :memos, through: :headings
  has_many :reading_logs, through: :memos
end
