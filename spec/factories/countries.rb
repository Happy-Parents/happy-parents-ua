# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :country do
    sequence(:name_uk) { |n| "#{FFaker::Address.country}-#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Address.country}-#{n}" }
  end
end
