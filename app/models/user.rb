# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :email, uniqueness: true
    validates :avatar_url
  end
end
