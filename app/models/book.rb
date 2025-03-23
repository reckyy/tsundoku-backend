# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, presence: true

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  scope :position_order, -> { order(position: :asc) }
end
