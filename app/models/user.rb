# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :email, uniqueness: true
    validates :avatar_url
  end

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books

  def self.find_or_create_user(user_info)
    user = User.find_by(id: user_info[:id])
    return user if user

    User.create!(user_info)
  end
end
