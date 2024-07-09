# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name_uk) { |n| "#{FFaker::Lorem.word}#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
