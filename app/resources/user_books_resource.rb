# frozen_string_literal: true

class UserBooksResource < BaseResource
  many :user_books,
       proc { |user_books|
         user_books.order(:position)
       },
       resource: UserBookResource
end
