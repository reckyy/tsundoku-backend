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
end
