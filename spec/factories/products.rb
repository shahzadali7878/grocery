# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name              { Faker::Lorem.word }
    description       { Faker::Lorem.sentence }
    price             { Faker::Number.decimal(l_digits: 3) }
    on_sale           { true }

    trait :without_name do
      name {}
    end

    trait :without_description do
      description {}
    end

    trait :with_less_description do
      description { Faker::Lorem.characters(number: 4) }
    end

    trait :with_extra_description do
      description { Faker::Lorem.characters(number: 251) }
    end

    trait :without_price do
      price {}
    end

    trait :with_zero_price do
      price { 0 }
    end

    trait :with_discounted_price do
      discounted_price { Faker::Number.decimal(l_digits: 2) }
    end

    trait :with_zero_discounted_price do
      discounted_price { 0 }
    end

    trait :with_discounted_price_more_than_price do
      discounted_price { Faker::Number.decimal(l_digits: 4) }
    end
  end
end
