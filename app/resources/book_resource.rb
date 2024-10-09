# frozen_string_literal: true

class BookResource < BaseResource
  attributes :id, :title, :author

  attribute :coverImageUrl, &:cover_image_url
end
