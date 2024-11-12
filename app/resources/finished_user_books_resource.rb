# frozen_string_literal: true

class FinishedUserBooksResource < BaseResource
  many :user_books,
       proc { |user_books|
         user_books.order(:position).select(&:status_finished?)
       },
       resource: UserBookResource
end
