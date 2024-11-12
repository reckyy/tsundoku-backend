# frozen_string_literal: true

class UserBookResource < BaseResource
  attributes :id, :status

  one :book, resource: BookResource do
    attributes :id, :author, :title
  end
end
