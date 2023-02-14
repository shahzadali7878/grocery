# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy

  validates :name, :description, presence: true
  validates :description, length: 5..250
end
