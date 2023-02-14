# frozen_string_literal: true

FactoryBot.define do
  factory :size do
    name { %w[small medium large].sample }
    code { %w[s m l].sample }

    trait :without_name do
      name {}
    end

    trait :without_code do
      code {}
    end
  end
end
