# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemoResource, type: :resource do
  it 'returns the attributes of the memo' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user:, book:)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    memo_json = MemoResource.new(memo).serializable_hash.to_json
    expected_memo_json = { id: memo.id, body: memo.body }.to_json
    expect(memo_json).to eq(expected_memo_json)
  end
end
