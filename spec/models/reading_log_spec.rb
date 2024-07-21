# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReadingLog, type: :model do
  before do
    @reading_log = FactoryBot.create(:reading_log)
  end

  it 'is valid' do
    expect(@reading_log).to be_valid
  end

  it 'same day logs cannot exist' do
    same_day_reading_log = ReadingLog.new(memo_id: @reading_log.memo.id, read_date: Date.new(2024, 7, 21))
    expect(same_day_reading_log).to be_invalid
  end
end
