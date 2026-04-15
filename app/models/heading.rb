# frozen_string_literal: true

class Heading < ApplicationRecord
  belongs_to :user_book
  has_one :memo, dependent: :destroy

  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  accepts_nested_attributes_for :memo
end
