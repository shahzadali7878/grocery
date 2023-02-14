# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category)                        { build(:category) }
  let(:category_without_name)           { build(:category, :without_name) }
  let(:category_without_description)    { build(:category, :without_description) }
  let(:category_with_less_description)  { build(:category, :with_less_description) }
  let(:category_with_extra_description) { build(:category, :with_extra_description) }

  it 'is valid with valid attributes' do
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    expect(category_without_name).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(category_without_description).to_not be_valid
  end

  it 'is not valid with less description' do
    expect(category_with_less_description).to_not be_valid
  end

  it 'is not valid with extra description' do
    expect(category_with_extra_description).to_not be_valid
  end
end
