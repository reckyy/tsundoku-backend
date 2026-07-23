# frozen_string_literal: true

class MakeMemoBodyNonNullable < ActiveRecord::Migration[8.0]
  def change
    change_table :memos, bulk: true do |t|
      t.change_default :body, from: nil, to: ''
      t.change_null :body, false, ''
    end
  end
end
