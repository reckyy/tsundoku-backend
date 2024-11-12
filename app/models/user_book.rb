# frozen_string_literal: true

class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :headings, dependent: :destroy

  validates :user_id, uniqueness: { scope: :book_id }

  enum :status, { unread: 0, reading: 1, finished: 2 }, prefix: true

  acts_as_list scope: :user

  def swap_positions_with(item)
    item_position = item.position

    item.set_list_position(position)
    set_list_position(item_position)
  end

  def save_with_heading
    save && headings.create!(number: 1, title: '', memo_attributes: {})
  end
end
