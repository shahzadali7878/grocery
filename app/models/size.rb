# frozen_string_literal: true

class Size < ApplicationRecord
  has_many :product_sizes, dependent: :destroy
  has_many :products, through: :product_sizes

  validates :name, :code, presence: true
end
