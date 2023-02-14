# frozen_string_literal: true

class Color < ApplicationRecord
  has_many :product_colors, dependent: :destroy
  has_many :products, through: :product_colors

  validates :name, :code, presence: true
  validates :code, format: { with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/i }
end
