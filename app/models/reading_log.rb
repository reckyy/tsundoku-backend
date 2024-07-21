# frozen_string_literal: true

class ReadingLog < ApplicationRecord
  belongs_to :memo

  validates :read_date, presence: true
  validates :memo_id, uniqueness: { scope: :read_date }
end
