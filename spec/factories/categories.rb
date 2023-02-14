# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name        { Faker::Lorem.word }
    description { Faker::Lorem.sentence }

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
  end
end
