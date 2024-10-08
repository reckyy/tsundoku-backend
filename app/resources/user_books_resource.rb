# frozen_string_literal: true

class UserBooksResource < BaseResource
  many :books, resource: BookResource
end
