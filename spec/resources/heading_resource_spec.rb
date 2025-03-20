# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeadingResource, type: :resource do
  before do
    @heading = FactoryBot.create(:heading)
    @memo = FactoryBot.create(:memo, heading: @heading)
  end

  it 'returns the attributes of the heading with memo' do
    heading_json = HeadingResource.new(@heading).serializable_hash.to_json
    expected_heading_json = { id: @heading.id, number: @heading.number, title: @heading.title, memo: { id: @memo.id, body: @memo.body } }.to_json
    expect(heading_json).to eq(expected_heading_json)
  end
end
