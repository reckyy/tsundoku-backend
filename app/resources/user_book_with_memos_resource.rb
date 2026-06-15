# frozen_string_literal: true

class UserBookWithMemosResource < BaseResource
  attributes :id, :status
  one :book, resource: BookResource

  many :ordered_headings, key: :headings, resource: HeadingResource
end
