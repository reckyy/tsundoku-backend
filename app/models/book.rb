# frozen_string_literal: true

class Book < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :author
    validates :cover_image_url
  end

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  scope :position_order, -> { order(position: :asc) }

  def save_with_user_book(user, heading_number)
    Book.transaction do
      succeeded = save
      succeeded = save_user_book(user, heading_number) if succeeded
      raise ActiveRecord::Rollback unless succeeded

      succeeded
    end
  end

  def save_user_book(user, heading_number)
    position = UserBook.all.length + 1
    user_book = UserBook.find_or_create_by!(user:, book: self, position:)
    return false if heading_number.zero? # もしheading_numberがnilなら0になるため

    insert_chapter(user_book, heading_number)
  end

  def insert_chapter(user_book, heading_number)
    (1..heading_number).map do |n|
      user_book.headings.create!(number: n, title: '', memo_attributes: {})
    end
    true
  end
end
