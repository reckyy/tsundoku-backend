# frozen_string_literal: true

class UserBooksResource < BaseResource
  many :books,
       proc { |books|
       books.order(:position)
     },
     resource: BookResource
end
