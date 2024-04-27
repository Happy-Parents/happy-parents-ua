# frozen_string_literal: true

# == Schema Information
#
# Table name: manufacturers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  country_id :bigint
#
# Indexes
#
#  index_manufacturers_on_country_id  (country_id)
#  index_manufacturers_on_name        (name) UNIQUE
#
FactoryBot.define do
  factory :manufacturer
  sequence(:name) { |n| "#{FFaker::Lorem.word}-#{n}" }
end
