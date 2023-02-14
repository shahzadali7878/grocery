# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  let(:category) { create(:category) }

  let(:sub_category)                        { build(:sub_category, category: category) }
  let(:sub_category_without_name)           { build(:sub_category, :without_name, category: category) }
  let(:sub_category_without_description)    { build(:sub_category, :without_description, category: category) }
  let(:sub_category_with_less_description)  { build(:sub_category, :with_less_description, category: category) }
  let(:sub_category_with_extra_description) { build(:sub_category, :with_extra_description, category: category) }

  it 'is valid with valid attributes' do
    expect(sub_category).to be_valid
  end

  it 'is not valid without a name' do
    expect(sub_category_without_name).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(sub_category_without_description).to_not be_valid
  end

  it 'is not valid with less description' do
    expect(sub_category_with_less_description).to_not be_valid
  end

  it 'is not valid with extra description' do
    expect(sub_category_with_extra_description).to_not be_valid
  end
end
