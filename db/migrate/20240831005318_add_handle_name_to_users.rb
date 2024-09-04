# frozen_string_literal: true

class AddHandleNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :handle_name, :string
    add_index :users, :handle_name, unique: true
  end
end
