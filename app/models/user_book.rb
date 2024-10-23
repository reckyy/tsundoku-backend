# frozen_string_literal: true

class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :headings, dependent: :destroy

  validates :user_id, uniqueness: { scope: :book_id }

  acts_as_list

  def swap_positions_with(item)
    item_position = item.current_position

    item.set_list_position(current_position)
    set_list_position(item_position)
  end

  def save_with_heading(heading_number)
    return false if heading_number.zero? # もしheading_numberがnilなら0になるため

    save && insert_heading(heading_number)
  end

  private

  def insert_heading(heading_number)
    (1..heading_number).map do |n|
      headings.create!(number: n, title: '', memo_attributes: {})
    end
  end
end
