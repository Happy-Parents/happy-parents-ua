# frozen_string_literal: true

# == Schema Information
#
# Table name: manufacturers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint
#
# Indexes
#
#  index_manufacturers_on_country_id           (country_id)
#  index_manufacturers_on_name_and_country_id  (name,country_id) UNIQUE
#
FactoryBot.define do
  factory :manufacturer do
    country
    sequence(:name) { |n| "#{FFaker::Lorem.word}-#{n}" }
  end
end
