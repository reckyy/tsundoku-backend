# frozen_string_literal: true

class Heading < ApplicationRecord
  belongs_to :user_book
  has_one :memo, dependent: :destroy

  accepts_nested_attributes_for :memo
end
