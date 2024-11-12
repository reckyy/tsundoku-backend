# frozen_string_literal: true

class ReadingUserBooksResource < BaseResource
  many :user_books,
       proc { |user_books|
         user_books.order(:position).select(&:status_reading?)
       },
       resource: UserBookResource
end
