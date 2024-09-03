# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :email, uniqueness: true
    validates :avatar_url
    validates :uid
    validates :handle_name, uniqueness: true
  end

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :headings, through: :user_books
  has_many :memos, through: :headings
  has_many :reading_logs, through: :memos

  def info
    reading_log = reading_logs.group(:read_date).count
    results = reading_log.map { |date, count| { date: date.to_s, count: } }
    { books:, logs: results }
  end
end
