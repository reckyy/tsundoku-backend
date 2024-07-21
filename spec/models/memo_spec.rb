# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Memo, type: :model do
  it 'is valid' do
    memo = FactoryBot.build(:memo)
    expect(memo).to be_valid
  end
end
