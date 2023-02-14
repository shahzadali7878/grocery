# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Size, type: :model do
  let(:size)              { build(:size) }
  let(:size_without_name) { build(:size, :without_name) }
  let(:size_without_code) { build(:size, :without_code) }

  it 'is valid with valid attributes' do
    expect(size).to be_valid
  end

  it 'is not valid without a name' do
    expect(size_without_name).to_not be_valid
  end

  it 'is not valid without a code' do
    expect(size_without_code).to_not be_valid
  end
end
