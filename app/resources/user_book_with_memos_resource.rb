# frozen_string_literal: true

class UserBookWithMemosResource < BaseResource
  attributes :id, :status
  one :book, resource: BookResource

  many :headings,
       proc { |headings|
         headings.order(:id)
       },
       resource: HeadingResource
end
