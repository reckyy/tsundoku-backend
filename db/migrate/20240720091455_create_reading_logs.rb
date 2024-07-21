# frozen_string_literal: true

class CreateReadingLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_logs do |t|
      t.date :read_date, null: false
      t.references :memo, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reading_logs, %i[memo_id read_date], unique: true
  end
end
