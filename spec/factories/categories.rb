# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :category do
    sequence(:name_uk) { |n| "#{FFaker::Lorem.word}#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Lorem.word}#{n}" }
    sequence(:slug) { |n| "#{FFaker::Lorem.word}#{n}" }
  end
end
