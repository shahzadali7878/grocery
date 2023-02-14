# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category)     { create(:category) }
  let(:sub_category) { create(:sub_category, category: category) }
  let(:product)      { build(:product, sub_category: sub_category) }

  let(:product_without_name) { build(:product, :without_name, sub_category: sub_category) }

  let(:product_without_description)    { build(:product, :without_description,    sub_category: sub_category) }
  let(:product_with_less_description)  { build(:product, :with_less_description,  sub_category: sub_category) }
  let(:product_with_extra_description) { build(:product, :with_extra_description, sub_category: sub_category) }

  let(:product_without_price)   { build(:product, :without_price,   sub_category: sub_category) }
  let(:product_with_zero_price) { build(:product, :with_zero_price, sub_category: sub_category) }

  let(:product_with_discounted_price)      { build(:product, :with_discounted_price,      sub_category: sub_category) }
  let(:product_with_zero_discounted_price) { build(:product, :with_zero_discounted_price, sub_category: sub_category) }

  let(:product_with_discounted_price_more_than_price) {
    build(:product, :with_discounted_price_more_than_price, sub_category: sub_category)
  }

  it 'is valid with valid attributes' do
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    expect(product_without_name).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(product_without_description).to_not be_valid
  end

  it 'is not valid with less description' do
    expect(product_with_less_description).to_not be_valid
  end

  it 'is not valid with extra description' do
    expect(product_with_extra_description).to_not be_valid
  end

  it 'is not valid without price' do
    expect(product_without_price).to_not be_valid
  end

  it 'is not valid with zero price' do
    expect(product_with_zero_price).to_not be_valid
  end

  it 'is valid with discounted price' do
    expect(product_with_discounted_price).to be_valid
  end

  it 'is not valid with zero discounted price' do
    expect(product_with_zero_discounted_price).to_not be_valid
  end

  it 'is not valid with discounted price greater than price' do
    expect(product_with_discounted_price_more_than_price).to_not be_valid
  end
end
