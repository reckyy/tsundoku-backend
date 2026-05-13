# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with factory defaults' do
    user = FactoryBot.build(:user)

    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name: nil)

    expect(user).not_to be_valid
  end

  it 'is invalid without an email' do
    user = FactoryBot.build(:user, email: nil)

    expect(user).not_to be_valid
  end

  it 'is invalid when email is already taken' do
    existing = FactoryBot.create(:user)
    user = FactoryBot.build(:user, email: existing.email)

    expect(user).not_to be_valid
  end

  it 'is invalid without an avatar_url' do
    user = FactoryBot.build(:user, avatar_url: nil)

    expect(user).not_to be_valid
  end
end
