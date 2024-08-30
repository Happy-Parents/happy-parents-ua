# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id :bigint           not null, primary key
#
FactoryBot.define do
  factory :skill do
    sequence(:name_uk) { |n| "#{FFaker::Address.country}-#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Address.country}-#{n}" }
  end
end
