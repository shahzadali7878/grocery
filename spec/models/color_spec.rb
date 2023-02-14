# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Color, type: :model do
  let(:color)              { build(:color) }
  let(:color_without_name) { build(:color, :without_name) }
  let(:color_without_code) { build(:color, :without_code) }

  it 'is valid with valid attributes' do
    expect(color).to be_valid
  end

  it 'is not valid without a name' do
    expect(color_without_name).to_not be_valid
  end

  it 'is not valid without a code' do
    expect(color_without_code).to_not be_valid
  end
end
