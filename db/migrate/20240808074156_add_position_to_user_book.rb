# frozen_string_literal: true

class AddPositionToUserBook < ActiveRecord::Migration[7.1]
  def change
    add_column :user_books, :position, :integer
  end
end
