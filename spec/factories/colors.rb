# frozen_string_literal: true

FactoryBot.define do
  factory :color do
    name { Faker::Color.color_name }
    code { Faker::Color.hex_color }

    trait :without_name do
      name {}
    end

    trait :without_code do
      code {}
    end
  end
end
