# frozen_string_literal: true

class UserBooksResource < BaseResource
  many :unread_books, resource: UserBookResource
  many :reading_books, resource: UserBookResource
  many :finished_books, resource: UserBookResource
end
