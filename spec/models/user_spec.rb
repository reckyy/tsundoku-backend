# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name, email and avatar_url' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without name' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to be_invalid
  end

  it 'is invalid without email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to be_invalid
  end

  it 'is invalid without avatar_url' do
    user = FactoryBot.build(:user, avatar_url: nil)
    expect(user).to be_invalid
  end

  it 'is invalid with a duplicate email' do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')
    expect(user).to be_invalid
  end
end
