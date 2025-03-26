# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeadingResource, type: :resource do
  it 'returns the attributes of the heading with memo' do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user_book = UserBook.create(user:, book:)
    heading = FactoryBot.create(:heading, user_book:)
    memo = FactoryBot.create(:memo, heading:)
    heading_json = HeadingResource.new(heading).serializable_hash.to_json
    expected_heading_json = { id: heading.id, number: heading.number, title: heading.title, memo: { id: memo.id, body: memo.body } }.to_json
    expect(heading_json).to eq(expected_heading_json)
  end
end
