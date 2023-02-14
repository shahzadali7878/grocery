# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :sub_category

  has_many :product_colors, dependent: :destroy
  has_many :colors, through: :product_colors
  has_many :product_sizes, dependent: :destroy
  has_many :sizes, through: :product_sizes

  validates :name, :description, :price, presence: true
  validates :description, length: 5..250
  validates :price, numericality: { greater_than: 0 }
  validates :discounted_price, numericality: { greater_than: 0 }, allow_nil: true
  validate :discounted_price_limit

  def color_ids
    colors.ids
  end

  def color_ids=(ids)
    self.colors = Color.find(ids.compact_blank)
  end

  def size_ids
    sizes.ids
  end

  def size_ids=(ids)
    self.sizes = Size.find(ids.compact_blank)
  end

  private

  def discounted_price_limit
    return if discounted_price.blank? || price > discounted_price

    errors.add(:discounted_price, 'should not be greater then original price')
  end
end
