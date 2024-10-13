# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemoResource, type: :resource do
  before do
    @memo = FactoryBot.create(:memo)
  end

  it 'returns the attributes of the memo' do
    memo_json = MemoResource.new(@memo).serialize
    expected_memo_json = { id: @memo.id, body: @memo.body }.to_json
    expect(memo_json).to eq(expected_memo_json)
  end
end
