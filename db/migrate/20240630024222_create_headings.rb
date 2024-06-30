class CreateHeadings < ActiveRecord::Migration[7.1]
  def change
    create_table :headings do |t|
      t.integer :number
      t.string :title
      t.references :user_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
