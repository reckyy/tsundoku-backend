# frozen_string_literal: true

class Book < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :author
    validates :cover_image_url
  end
end
