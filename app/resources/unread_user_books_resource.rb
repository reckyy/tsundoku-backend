# frozen_string_literal: true

class UnreadUserBooksResource < BaseResource
  many :user_books,
       proc { |user_books|
         user_books.order(:position).select(&:status_unread?)
       },
       resource: UserBookResource
end
