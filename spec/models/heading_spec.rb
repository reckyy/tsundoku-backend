# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heading, type: :model do
  it 'is valid' do
    heading = FactoryBot.build(:heading)
    expect(heading).to be_valid
  end
end
