# frozen_string_literal: true

class SubCategory < ApplicationRecord
  belongs_to :category

  has_many :products, dependent: :destroy

  validates :name, :description, presence: true
  validates :description, length: 5..250
end
