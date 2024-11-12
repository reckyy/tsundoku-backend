# frozen_string_literal: true

class AddStatusToUserBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :user_books, :status, :integer, null: false, default: 0
  end
end
