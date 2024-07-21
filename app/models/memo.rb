# frozen_string_literal: true

class Memo < ApplicationRecord
  belongs_to :heading
  has_many :reading_logs, dependent: :destroy
end
